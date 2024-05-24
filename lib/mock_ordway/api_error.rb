module MockOrdway
  class ApiError
    def self.handle
      yield
    rescue Faraday::ClientError => e
      Rails.logger.error "Client error: #{e.message}\n Details: #{JSON.parse(e.response[:body])}"
      Response.new(false, JSON.parse(e.response[:body]))
    rescue Faraday::ResourceNotFound => e
      Rails.logger.error "Resource not found: #{e.message} \n Details: #{JSON.parse(e.response[:body])}"
      Response.new(false)
    rescue Faraday::ServerError => e
      Rails.logger.error "Server error: #{e.message} \n Details: #{JSON.parse(e.response[:body])}"
      Response.new(false)
    rescue Faraday::ConnectionFailed => e
      Rails.logger.error "Connection failed: #{e.message} \n Details: #{JSON.parse(e.response[:body])}"
      Response.new(false)
    rescue Faraday::TimeoutError => e
      Rails.logger.error "Timeout error: #{e.message} \n Details: #{JSON.parse(e.response[:body])}"
      Response.new(false)
    rescue StandardError => e
      Rails.logger.error "An error occurred: #{e.message} \n Details: #{JSON.parse(e.response[:body])}"
      Response.new(false)
    end
  end
end
