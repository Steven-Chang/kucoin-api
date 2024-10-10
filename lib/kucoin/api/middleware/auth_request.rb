# frozen_string_literal: true

module Kucoin
  module Api
    module Middleware
      class AuthRequest < Faraday::Middleware
        def initialize(app, api_key, api_secret, api_passphrase)
          super(app)
          @api_key = api_key.to_s
          @api_secret = api_secret.to_s
          @api_passphrase = api_passphrase.to_s
        end

        def call(env)
          raise Kucoin::Api::MissingApiKeyError, 'API KEY not provided' if @api_key.empty?
          raise Kucoin::Api::MissingApiSecretError, 'API SECRET not provided' if @api_secret.empty?
          raise Kucoin::Api::MissingApiPassphraseError, 'API PASSPHRASE not provided' if @api_passphrase.empty?

          env[:request_headers]['KC-API-KEY'] = @api_key
          env[:request_headers]['KC-API-SIGN'] = signature(env)
          env[:request_headers]['KC-API-PASSPHRASE'] = @api_passphrase
          @app.call env
        end

        private

        def signature(env)
          Base64.strict_encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), @api_secret, str_to_sign(env)))
        end

        def str_to_sign(env)
          "#{env[:request_headers]['KC-API-TIMESTAMP']}#{env.method.upcase}#{env.url.request_uri}#{query_string(env)}"
        end

        def query_string(env)
          return if %i[get delete].include?(env.method.to_sym)

          params = {}
          begin
            params.merge!(::JSON.parse(env.body.to_s))
          rescue JSON::ParserError
          end
          params.to_json
        end
      end
    end
  end
end
