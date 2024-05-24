# frozen_string_literal: true

module MockOrdway
  module RequestHandlers
    class Customers < Base
      private

      def post
        customer = Models::Customer.create(params)
        Ordway::Response.new(true, customer)
      end

      def get
        customer = Models::Customer.find(id)
        Ordway::Response.new(true, customer)
      end
    end
  end
end
