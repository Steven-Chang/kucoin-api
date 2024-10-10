# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class Markets
        class OrderBook < Markets
          def part(symbol, depth)
            options = { symbol: symbol, depth: depth }
            assert_required_param options, :depth, depth_types
            open.ku_request :get, :part_aggregated, **options
          end

          def full_aggregated(symbol)
            open.ku_request :get, :full_aggregated, symbol: symbol
          end

          def full_atomic(symbol)
            open.ku_request :get, :full_atomic, symbol: symbol
          end

          private

          def depth_types
            %w[20 100]
          end
        end
      end
    end
  end
end
