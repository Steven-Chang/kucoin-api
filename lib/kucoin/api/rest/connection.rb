# frozen_string_literal: true

module Kucoin
  module Api
    class REST
      class Connection
        attr_reader :endpoint, :client

        def initialize(endpoint, options = {}, &block)
          @endpoint = endpoint
          @client = ::Faraday.new(options, &block)
        end

        def ku_request(method, subpath, options = {})
          response = client.public_send(method) do |req|
            # substitute path parameters and remove from options hash
            endpoint_url = endpoint.url(subpath).dup
            options.each do |option, value|
              path_param = /:#{option}/
              if endpoint_url.match? path_param
                options.delete(option)
                endpoint_url.gsub!(path_param, value.to_s)
              end
            end

            req.url endpoint_url

            # parameters go into request body, not headers on POSTs
            if method == :post
              req.body = options
            else
              req.params.merge!(options)
            end
          end
          success_or_error response
        end

        private

        def success_or_error(response)
          body = response.body.is_a?(Hash) ? response.body : JSON.parse(response.body)
          return body['data'] if body['code'].to_i == 200_000
          return body if response.status == 200

          raise Kucoin::Api::ClientError, "#{body['code'] || body['status']} - #{body['msg'] || body['message']}"
        rescue StandardError => e
          raise Kucoin::Api::ClientError, "#{e.message}\n#{response.body}"
        end
      end
    end
  end
end
