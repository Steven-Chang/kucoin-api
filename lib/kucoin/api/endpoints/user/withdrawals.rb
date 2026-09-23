# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class User
        class Withdrawals < User
          # Abandoned. KuCoin recommends create_v3.
          def create(currency, address, amount, options = {})
            auth.ku_request :post, :index, currency: currency, address: address, amount: amount, **options
          end
          alias apply create

          # https://www.kucoin.com/docs-new/rest/account-info/withdrawals/withdraw-v3
          def create_v3(currency, to_address, amount, chain, options = {})
            options = {
              currency: currency,
              toAddress: to_address,
              amount: amount,
              chain: chain,
              withdrawType: 'ADDRESS'
            }.merge(options)
            auth.ku_request :post, :create_v3, **options
          end
          alias apply_v3 create_v3

          def index(options = {})
            auth.ku_request :get, :index, **options
          end
          alias all index
          alias list index

          def quotas(currency)
            auth.ku_request :get, :quotas, currency: currency
          end

          def show(withdrawal_id)
            auth.ku_request :get, :show, withdrawal_id: withdrawal_id
          end
          alias get show

          def delete(withdrawal_id)
            auth.ku_request :delete, :delete, withdrawal_id: withdrawal_id
          end
          alias cancel delete
        end
      end
    end
  end
end
