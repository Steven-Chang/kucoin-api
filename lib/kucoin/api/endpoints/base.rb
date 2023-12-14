# frozen_string_literal: true
module Kucoin
  module Api
    module Endpoints
      class Base
        attr_reader :client
        def initialize client
          @client = client
        end

        def open
          client.open(self)
        end

        def auth
          client.auth(self)
        end

        def path
          self.class.name
            .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
            .gsub(/([a-z\d])([A-Z])/,'\1_\2')
            .tr('-', '_')
            .downcase.split('::')[3..-1].join('::')
        end

        def url action
          path_array = path.split('::').map(&:to_sym)
          path_array.reduce(Kucoin::Api::ENDPOINTS) { |m, k| m.fetch(k, {}) }[action]
        end

        def assert_required_param options, param, valid_values=nil
          raise Kucoin::Api::MissingParamError.new("#{param} is required") unless options.has_key?(param)
          assert_param_is_one_of options, param, valid_values if valid_values
        end

        def assert_param_is_one_of options, param, valid_values
          return if valid_values.include? options[param].to_s
          raise Kucoin::Api::InvalidParamError.new("#{param} must be one of #{valid_values.inspect}")
        end

        private

        def margin_models
          %w(cross isolated)
        end

        def side_types
          %w(buy sell)
        end

        def order_types
          %w(limit market)
        end

        def account_types
          %w(main trade)
        end
      end
    end
  end
end
