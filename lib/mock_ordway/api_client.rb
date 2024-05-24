module MockOrdway
  class ApiClient
    attr_accessor :default_headers, :config

    def initialize(config = Configuration.default)
      @config = config
      @user_agent = "Ordway-SDK/#{VERSION}/ruby"
      @default_headers = {
        "Content-Type" => "application/json",
        "User-Agent" => @user_agent
      }
      @conn = "test"
    end

    def self.default
      @default ||= ApiClient.new
    end

    def call(method, url, params: {})
      parsed_path = Util.parse_path_from_url(url)
      parsed_params = Util.parse_params(JSON.parse(params))

      handler = RequestHandlers.const_get(parsed_path.resource.split('_').map(&:capitalize).join(''))
      resp = handler.call(method, parsed_path, parsed_params)
      rescue NameError => e
      if e.message.match?(/uninitialized constant #{parsed_path.resource.capitalize}/)
        raise MockOrdway::MissingRequestHandler parsed_path.resource
      end

      resp
    end

    def object_to_http_body(model)
      return model if model.nil? || model.is_a?(String)

      local_body = if model.is_a?(Array)
                     model.map { |m| object_to_hash(m) }
                   else
                     object_to_hash(model)
                   end
      local_body.to_json
    end

    def object_to_hash(obj)
      if obj.respond_to?(:to_hash)
        obj.to_hash
      else
        obj
      end
    end

    def update_params_for_auth!(header_params)
      %w[X-API-KEY X-User-Company X-User-Email X-User-Token].each do |auth_name|
        auth_setting = @config.auth_settings[auth_name]
        next unless auth_setting

        header_params[auth_setting[:key]] = auth_setting[:value]
      end
    end
  end
end