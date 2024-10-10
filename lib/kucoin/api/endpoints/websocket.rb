# frozen_string_literal: true

module Kucoin
  module Api
    module Endpoints
      class Websocket < Base
        def public
          Response.new(open.ku_request(:post, :public))
        end

        def private
          Response.new(auth.ku_request(:post, :private))
        end

        class Response
          attr_reader :token, :endpoint, :ping_interval

          def initialize(response)
            @token = response['token']
            @endpoint = response['instanceServers'][0]['endpoint']
            @ping_interval = response['instanceServers'][0]['pingInterval']
          end
        end
      end
    end
  end
end
