# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class User
        class Withdrawals < User
          def create(currency, address, amount, options = {})
            auth.ku_request :post, :index, currency: currency, address: address, amount: amount, **options
          end
          alias apply create

          def index(options = {})
            auth.ku_request :get, :index, **options
          end
          alias all index
          alias list index

          def quotas(currency)
            auth.ku_request :get, :quotas, currency: currency
          end

          def delete(withdrawal_id)
            auth.ku_request :delete, :delete, withdrawal_id: withdrawal_id
          end
          alias cancel delete
        end
      end
    end
  end
end
