# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class Trade
        class Fills < Trade
          # Abandoned. KuCoin recommends hf_index.
          def index(options = {})
            auth.ku_request :get, :index, **options
          end
          alias all index
          alias list index

          # https://www.kucoin.com/docs-new/rest/spot-trading/orders/get-trade-history
          def hf_index(symbol, options = {})
            auth.ku_request :get, :hf_index, symbol: symbol, **options
          end
          alias hf_list hf_index

          def recent
            auth.ku_request :get, :recent
          end
        end
      end
    end
  end
end
