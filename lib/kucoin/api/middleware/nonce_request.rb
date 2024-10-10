# frozen_string_literal: true

module Kucoin
  module Api
    module Middleware
      class NonceRequest < Faraday::Middleware
        def call(env)
          env[:request_headers]['KC-API-TIMESTAMP'] = DateTime.now.strftime('%Q')
          @app.call(env)
        end
      end
    end
  end
end
