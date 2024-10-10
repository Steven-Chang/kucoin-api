# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class Trade
        class Fills < Trade
          def index(options = {})
            auth.ku_request :get, :index, **options
          end
          alias all index
          alias list index

          def recent
            auth.ku_request :get, :recent
          end
        end
      end
    end
  end
end
