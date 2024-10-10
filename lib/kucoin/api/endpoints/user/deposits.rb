# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class User
        class Deposits < User
          def create(currency)
            auth.ku_request :post, :create, currency: currency
          end

          def index(options = {})
            auth.ku_request :get, :index, **options
          end
          alias all index
          alias list index

          def show(currency)
            auth.ku_request :get, :show, currency: currency
          end
          alias get show
          alias detail show
        end
      end
    end
  end
end
