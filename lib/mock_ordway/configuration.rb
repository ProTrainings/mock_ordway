module MockOrdway
  class Configuration
    attr_accessor :debugging, :logger, :timeout

    def initialize
      @timeout = 0
      @debugging = true
      @logger = defined?(Rails) ? Rails.logger : Logger.new($stdout)

      yield(self) if block_given?
    end

    # The default Configuration object.
    def self.default
      @default ||= Configuration.new
    end

    def configure
      yield(self) if block_given?
    end
  end
end
