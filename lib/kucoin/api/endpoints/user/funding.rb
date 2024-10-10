# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class User
        class Funding < User
          # https://www.kucoin.com/docs/rest/funding/funding-overview/get-account-detail-cross-margin
          def cross(options = {})
            auth.ku_request :get, :cross, **options
          end

          # https://www.kucoin.com/docs/rest/funding/funding-overview/get-account-detail-isolated-margin
          def isolated(options = {})
            auth.ku_request :get, :isolated, **options
          end
        end
      end
    end
  end
end
