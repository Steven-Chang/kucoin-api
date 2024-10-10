# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class Markets
        class Histories < Markets
          def trade(symbol)
            open.ku_request :get, :trade, symbol: symbol
          end

          def klines(symbol, type, options = {})
            open.ku_request :get, :klines, symbol: symbol, type: type, **options
          end
        end
      end
    end
  end
end
