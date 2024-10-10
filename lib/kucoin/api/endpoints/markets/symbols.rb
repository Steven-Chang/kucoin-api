# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class Markets
        class Symbols < Markets
          def index(options = {})
            open.ku_request :get, :index, **options
          end
          alias all index
        end
      end
    end
  end
end
