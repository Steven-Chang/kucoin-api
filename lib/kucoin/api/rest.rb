# frozen_string_literal: true

module Kucoin
  module Api
    class REST
      BASE_URL = 'https://api.kucoin.com'
      FUTURES_BASE_URL = 'https://api-futures.kucoin.com'
      SANDBOX_BASE_URL = 'https://openapi-sandbox.kucoin.com'

      extend Kucoin::Api::Endpoints
      generate_endpoint_methods

      attr_reader :adapter, :api_key, :api_secret, :api_passphrase, :futures

      def initialize(
        api_key: Kucoin::Api.default_key,
        api_secret: Kucoin::Api.default_secret,
        api_passphrase: Kucoin::Api.default_passphrase,
        adapter: Faraday.default_adapter,
        sandbox: false,
        futures: false
      )
        @api_key = api_key
        @api_secret = api_secret
        @api_passphrase = api_passphrase
        @adapter = adapter
        @sandbox = sandbox
        @futures = futures
      end

      def sandbox?
        @sandbox == true
      end

      # Currently it does not handle sandbox for futures
      def base_url
        return FUTURES_BASE_URL if @futures

        sandbox? ? SANDBOX_BASE_URL : BASE_URL
      end

      def open(endpoint)
        Connection.new(endpoint, url: base_url) do |conn|
          conn.request :json
          conn.response :json, content_type: 'application/json'
          conn.adapter adapter
        end
      end

      def auth(endpoint)
        Connection.new(endpoint, url: base_url) do |conn|
          conn.request :json
          conn.response :json, content_type: 'application/json'
          conn.use Kucoin::Api::Middleware::NonceRequest
          conn.use Kucoin::Api::Middleware::AuthRequest, api_key, api_secret, api_passphrase
          conn.adapter adapter
        end
      end
    end
  end
end
