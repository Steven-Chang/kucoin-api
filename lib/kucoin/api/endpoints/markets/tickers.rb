# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class Markets
        class Tickers < Markets
          def index
            open.ku_request :get, :index
          end
          alias all index

          def inside(symbol)
            open.ku_request :get, :inside, symbol: symbol
          end
        end
      end
    end
  end
end
