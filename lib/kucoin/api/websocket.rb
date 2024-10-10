# frozen_string_literal: true

module Kucoin
  module Api
    class Websocket
      class << self
        def request_id
          rand(Time.now.to_i)
        end

        def subscribe(channel:, params: {})
          stream = { id: request_id, privateChannel: false, response: true }.merge(params)
          params = {
            id: stream[:id], type: 'subscribe', topic: stream[:topic],
            privateChannel: stream[:privateChannel], response: stream[:response],
            tunnelId: stream[:tunnelId]
          }.reject { |_k, v| v.nil? }
          channel.send(params.to_json)
        end

        def open_tunnel(channel:, params: {})
          stream = { id: request_id, response: true }.merge(params)
          params = {
            id: stream[:id], type: 'openTunnel', newTunnelId: stream[:newTunnelId], response: stream[:response]
          }
          channel.send(params.to_json)
        end
      end

      attr_reader :rest_client

      def initialize(rest_client: Kucoin::Api::REST.new)
        @rest_client = rest_client
      end

      def connect(methods:, private: false, params: {})
        create_stream(private ? auth_client(params: params) : open_client(params: params), methods: methods)
      end

      # Public: Create a WebSocket stream
      #
      # :stream - The Hash used to define the stream
      #   :id             - Unique string to mark the request
      #   :topic          - The topic you want to subscribe to
      #   :privateChannel - The user will only receive messages related himself on the topic(default is false)
      #   :response       - To return the ack messages after the subscriptions succeed(default is true)
      #
      # :methods - The Hash which contains the event handler methods to pass to
      #            the WebSocket client
      #   :open    - The Proc called when a stream is opened (optional)
      #   :message - The Proc called when a stream receives a message
      #   :error   - The Proc called when a stream receives an error (optional)
      #   :close   - The Proc called when a stream is closed (optional)
      def start(stream:, methods:)
        channel = connect(private: !stream[:privateChannel].nil?, methods: methods)
        self.class.subscribe channel: channel, params: stream
        channel
      end

      # Public: Create a WebSocket stream for multiplex tunnels
      #
      # :stream - The Hash used to define the stream
      #   :id             - Unique string to mark the request
      #   :newTunnelId    - Required
      #   :privateChannel - The user will only receive messages related himself on the topic(default is false)
      #
      def multiplex(stream:, methods:)
        channel = connect(private: !stream[:privateChannel].nil?, methods: methods)
        self.class.open_tunnel channel: channel, params: stream
        channel
      end

      # PUBLIC
      def ticker(symbols:, methods:)
        start stream: { topic: topic_path('/market/ticker', symbols) }, methods: methods
      end

      def all_ticker(methods:)
        ticker symbols: :all, methods: methods
      end

      def snapshot(symbol:, methods:)
        start stream: { topic: "/market/snapshot:#{symbol}" }, methods: methods
      end
      alias symbol_snapshot snapshot
      alias market_snapshot snapshot

      def level_2_market_data(symbols:, methods:)
        start stream: { topic: topic_path('/market/level2', symbols) }, methods: methods
      end

      def match_execution_data(symbols:, methods:, private_channel: false)
        start stream: { topic: topic_path('/market/match', symbols), privateChannel: private_channel }, methods: methods
      end

      def full_match_engine_data(symbols:, methods:, private_channel: false)
        start stream: { topic: topic_path('/market/level3', symbols), privateChannel: private_channel },
              methods: methods
      end

      # PRIVATE
      def stop_order_received_event(symbols:, methods:)
        full_match_engine_data symbols: symbols, methods: methods, private_channel: true
      end
      alias stop_order_activate_event stop_order_received_event

      def balance(methods:)
        start stream: { topic: '/account/balance', privateChannel: true }, methods: methods
      end

      private

      def open_client(params: {})
        get_client(rest_client.websocket.public, params: params)
      end

      def auth_client(params: {})
        get_client(rest_client.websocket.private, params: params)
      end

      def get_client(response, params: {})
        url = ["#{response.endpoint}?token=#{response.token}", URI.encode_www_form(params)].join('&')
        Faye::WebSocket::Client.new(url, [], ping: response.ping_interval)
      end

      def create_stream(websocket, methods:)
        attach_methods websocket, methods
        websocket
      end

      # Internal: Iterate through methods passed and add them to the WebSocket
      #
      # websocket - The Faye::WebSocket::Client to apply methods to
      #
      # methods - The Hash which contains the event handler methods to pass to
      #   the WebSocket client
      #   :open    - The Proc called when a stream is opened (optional)
      #   :message - The Proc called when a stream receives a message
      #   :error   - The Proc called when a stream receives an error (optional)
      #   :close   - The Proc called when a stream is closed (optional)
      def attach_methods(websocket, methods)
        methods.each_pair do |key, method|
          websocket.on(key) { |event| method.call(event) }
        end
      end

      def topic_path(path, values = [])
        values = [values] unless values.is_a?(Array)
        "#{path}:#{values.compact.join(',')}"
      end
    end
  end
end
