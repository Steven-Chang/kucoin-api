# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class Trade
        class Orders < Trade
          # Abandoned. KuCoin recommends hf_create.
          def create(client_oid, side, symbol, options = {})
            options = { clientOid: client_oid, side: side, symbol: symbol }.merge(options)
            assert_required_param options, :side, side_types
            assert_param_is_one_of options, :type, order_types if options.key?(:type)
            auth.ku_request :post, :index, **options
          end
          alias place create

          # https://www.kucoin.com/docs-new/rest/spot-trading/orders/add-order
          def hf_create(symbol, side, type, options = {})
            options = { symbol: symbol, side: side, type: type }.merge(options)
            assert_required_param options, :side, side_types
            assert_param_is_one_of options, :type, order_types
            auth.ku_request :post, :hf_create, **options
          end
          alias hf_place hf_create

          # Abandoned. KuCoin recommends hf_active for open orders and hf_closed for done orders.
          # https://www.kucoin.com/docs-new/abandoned-endpoints/spot-trading/orders/get-orders-list-old
          def index(options = {})
            auth.ku_request :get, :index, **options
          end
          alias all index
          alias list index

          # https://www.kucoin.com/docs-new/rest/spot-trading/orders/get-open-orders-by-page
          def hf_active(symbol, options = {})
            auth.ku_request :get, :hf_active, symbol: symbol, **options
          end

          # https://www.kucoin.com/docs-new/rest/spot-trading/orders/get-closed-orders
          def hf_closed(symbol, options = {})
            auth.ku_request :get, :hf_closed, symbol: symbol, **options
          end

          def cancel_all_orders_by_symbol(symbol)
            auth.ku_request :delete, :cancel_all_orders_by_symbol, symbol:
          end

          def recent
            auth.ku_request :get, :recent
          end

          # Abandoned. KuCoin recommends hf_show.
          def show(order_id)
            auth.ku_request :get, :show, order_id: order_id
          end
          alias get show
          alias detail show

          # https://www.kucoin.com/docs-new/rest/spot-trading/orders/get-order-by-orderld
          def hf_show(order_id, symbol)
            auth.ku_request :get, :hf_show, order_id: order_id, symbol: symbol
          end
          alias hf_get hf_show

          # Abandoned. KuCoin recommends hf_delete.
          def delete(order_id)
            auth.ku_request :delete, :show, order_id: order_id
          end
          alias cancel delete

          # https://www.kucoin.com/docs-new/rest/spot-trading/orders/cancel-order-by-orderld
          def hf_delete(order_id, symbol)
            auth.ku_request :delete, :hf_show, order_id: order_id, symbol: symbol
          end
          alias hf_cancel hf_delete
        end
      end
    end
  end
end
