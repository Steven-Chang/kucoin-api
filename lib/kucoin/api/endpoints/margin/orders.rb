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
        end
      end
    end
  end
end
