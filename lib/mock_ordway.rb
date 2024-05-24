# Common files
require 'mock_ordway/api_client'
require 'mock_ordway/version'
require 'mock_ordway/configuration'
require "mock_ordway/api_error"
require "mock_ordway/errors"
require "mock_ordway/util"
require "mock_ordway/environment"
require "mock_ordway/repositories"
require "mock_ordway/models/base"
require "mock_ordway/models/customer"
require "mock_ordway/request_handlers/base"
require "mock_ordway/request_handlers/customers"

module MockOrdway
  @@environment = nil

  def self.start

    @@environment = Environment.new
    @@original_ordway_request = Ordway::ApiClient.method(:default)
    Ordway::ApiClient.define_singleton_method(:default, &MockOrdway::ApiClient.method(:default))
  end

  def self.environment
    @@environment
  end
end
