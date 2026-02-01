# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class Margin
        class Stops < Margin
          # https://www.kucoin.com/docs-new/rest/margin-trading/orders/get-stop-order-list
          def index(options = {})
            auth.ku_request :get, :index, **options
          end

          # https://www.kucoin.com/docs-new/rest/margin-trading/orders/add-stop-order
          def create(client_oid, side, symbol, stop_price, options = {})
            options = { clientOid: client_oid, side:, symbol:, stopPrice: stop_price }.merge(options)
            assert_required_param options, :side, side_types
            assert_param_is_one_of options, :type, order_types if options.key?(:type)
            auth.ku_request :post, :index, **options
          end
          alias place create

          # https://www.kucoin.com/docs-new/rest/margin-trading/orders/get-stop-order-by-clientoid
          def show(order_id)
            auth.ku_request :get, :show, clientOid: order_id
          end

          # https://www.kucoin.com/docs-new/rest/margin-trading/orders/cancel-stop-order-by-orderld
          def delete(order_id)
            auth.ku_request :delete, :delete, orderId: order_id
          end
          alias cancel delete
        end
      end
    end
  end
end
