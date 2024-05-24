# frozen_string_literal: true

module MockOrdway
  module RequestHandlers
    class Base
      def self.call(http_method, parsed_path, params = {})
        new(http_method, parsed_path, params).call
      end

      def initialize(http_method, parsed_path, params)
        @http_method = http_method
        @parsed_path = parsed_path
        @params = params
      end

      def call
        send("#{http_method}#{sub_command}")
      end

      private

      attr_reader :http_method, :parsed_path, :params, :env

      delegate :id, :sub_command, to: :parsed_path

      def self.load_fixtures(*args)
        args.each do |arg|
          define_method("#{arg}_fixture") do
            instance_variable_get("@#{arg}_fixture") ||
              instance_variable_set("@#{arg}_fixture", JSON.parse(File.read("#{File.dirname(__FILE__)}/../fixtures/#{arg}.json")))
          end
        end
      end
    end
  end
end
