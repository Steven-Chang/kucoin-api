# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class Markets < Base
        def index
          open.ku_request :get, :index
        end
        alias all index

        def stats(symbol)
          open.ku_request :get, :stats, symbol: symbol
        end
      end
    end
  end
end
