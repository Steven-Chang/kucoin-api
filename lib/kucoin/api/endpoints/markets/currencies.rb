# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class Markets
        class Currencies < Markets
          def index(options = {})
            open.ku_request :get, :index, options
          end
          alias all index

          def fiat(options = {})
            open.ku_request :get, :fiat, options
          end

          def show(currency)
            open.ku_request :get, :show, currency: currency
          end
          alias detail show
        end
      end
    end
  end
end
