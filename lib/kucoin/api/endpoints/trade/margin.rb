# frozen_string_literal: true
module Kucoin
  module Api
    module Endpoints
      class Trade
        class Margin < Trade
          def create client_oid, side, symbol, margin_model, options={}
            options = { clientOid: client_oid, side: side, symbol: symbol, marginModel: margin_model }.merge(options)
            assert_required_param options, :side, side_types
            assert_param_is_one_of options, :type, order_types if options.has_key?(:type)
            assert_param_is_one_of options, :marginModel, margin_models if options.has_key?(:marginModel)
            auth.ku_request :post, :create, **options
          end
          alias place create

          # https://www.kucoin.com/docs/rest/margin-trading/isolated-margin/get-single-isolated-margin-account-info
          def isolated_account(symbol)
            auth.ku_request :get, :isolated_account, symbol:
          end
        end
      end
    end
  end
end
