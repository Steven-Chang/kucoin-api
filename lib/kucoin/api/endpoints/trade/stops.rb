# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class Trade
        class Stops < Trade
          # https://www.kucoin.com/docs/rest/spot-trading/stop-order/place-order
          def create(client_oid, side, symbol, stop_price, options = {})
            options = { clientOid: client_oid, side:, symbol:, stopPrice: stop_price }.merge(options)
            assert_required_param options, :side, side_types
            assert_param_is_one_of options, :type, order_types if options.key?(:type)
            assert_param_is_one_of options, :tradeType, stop_trade_types if options.key?(:tradeType)
            auth.ku_request :post, :index, **options
          end
          alias place create

          # https://www.kucoin.com/docs/rest/spot-trading/stop-order/get-stop-orders-list
          def index(options = {})
            auth.ku_request :get, :index, **options
          end
          alias all index
          alias list index
        end
      end
    end
  end
end
