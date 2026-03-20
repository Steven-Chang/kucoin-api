# frozen_string_literal: true

module Kucoin
  module Api
    module Middleware
      # Faraday 2 middleware entrypoint.
      # The old `faraday_middleware` gem is deprecated; this adapter uses
      # Faraday's built-in `Faraday::Middleware` API.
      class NonceRequest < Faraday::Middleware
        def call(env)
          env[:request_headers]['KC-API-TIMESTAMP'] = DateTime.now.strftime('%Q')
          @app.call(env)
        end
      end
    end
  end
end
