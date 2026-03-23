# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class Margin
        class Orders < Margin
          def delete(order_id, symbol)
            auth.ku_request :delete, :show, order_id: order_id, symbol: symbol
          end
          alias cancel delete

          # https://www.kucoin.com/docs-new/rest/margin-trading/orders/cancel-all-orders-by-symbol
          def cancel_all_orders_by_symbol(symbol, trade_type)
            auth.ku_request :delete, :cancel_all_orders_by_symbol, symbol:, tradeType: trade_type
          end
        end
      end
    end
  end
end
