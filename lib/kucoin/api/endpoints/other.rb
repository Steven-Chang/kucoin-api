# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class Other < Base
        def timestamp
          auth.ku_request :get, :timestamp
        end
      end
    end
  end
end
