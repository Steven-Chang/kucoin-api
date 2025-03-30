# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class User
        class Accounts < User
          def create(currency, type)
            options = { currency: currency, type: type }
            assert_param_is_one_of options, :type, account_types
            auth.ku_request :post, :index, **options
          end

          def index(options = {})
            auth.ku_request :get, :index, **options
          end
          alias all index
          alias list index

          # Updated to v2
          def inner_transfer(client_oid, currency, from, to, amount, options = {})
            auth.ku_request :post, :inner_transfer, clientOid: client_oid, currency: currency, from: from, to: to,
                                                    amount: amount, **options
          end

          def show(account_id)
            auth.ku_request :get, :show, account_id: account_id
          end
          alias get show
          alias detail show

          def ledgers(account_id, options = {})
            auth.ku_request :get, :ledgers, account_id: account_id, **options
          end

          def holds(account_id)
            auth.ku_request :get, :holds, account_id: account_id
          end

          # https://www.kucoin.com/docs/rest/funding/transfer/transfer-to-main-or-trade-account
          def transfer_from_futures_account(amount, currency, rec_account_type)
            auth.ku_request :post, :transfer_from_futures_account, amount:, currency:, recAccountType: rec_account_type
          end

          # https://www.kucoin.com/docs/rest/funding/transfer/transfer-to-futures-account
          def transfer_to_futures_account(amount, currency, pay_account_type)
            auth.ku_request :post, :transfer_to_futures_account, amount:, currency:, payAccountType: pay_account_type
          end
        end
      end
    end
  end
end
