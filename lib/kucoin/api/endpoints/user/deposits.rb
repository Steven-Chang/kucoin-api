# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class User
        class Deposits < User
          # Abandoned. KuCoin recommends create_v3.
          def create(currency)
            auth.ku_request :post, :create, currency: currency
          end

          # https://www.kucoin.com/docs-new/rest/account-info/deposit/add-deposit-address-v3
          def create_v3(currency, chain, options = {})
            auth.ku_request :post, :create_v3, currency: currency, chain: chain, **options
          end

          def index(options = {})
            auth.ku_request :get, :index, **options
          end
          alias all index
          alias list index

          # Abandoned. KuCoin recommends show_v3.
          def show(currency)
            auth.ku_request :get, :show, currency: currency
          end
          alias get show
          alias detail show

          # https://www.kucoin.com/docs-new/rest/account-info/deposit/get-deposit-address-v3
          def show_v3(currency, options = {})
            auth.ku_request :get, :show_v3, currency: currency, **options
          end
          alias get_v3 show_v3
        end
      end
    end
  end
end
