# frozen_string_literal: true

RSpec.describe Kucoin::Api::Websocket do
  let(:request_url) { "#{Kucoin::Api::REST::BASE_URL}#{request_path}" }
  before do
    allow(described_class).to receive(:request_id).and_return(981_147_906)
    stub_request(:post, request_url).to_return(body: acquire_websocket_servers_response.to_json)
  end
  let(:market_symbol) { 'ETH-BTC' }
  let(:rest_client) { Kucoin::Api::REST.new(api_key: 'api_key', api_secret: 'secret', api_passphrase: 'passphrase') }
  let(:client) { Kucoin::Api::Websocket.new(rest_client: rest_client) }

  context '#multiplex' do
    let(:request_path)  { '/api/v1/bullet-public' }
    let(:response_data) { { 'id' => 981_147_906, 'newTunnelId' => 'bt1', 'response' => true, 'type' => 'openTunnel' } }

    it 'return valid response' do
      mock_websocket_server do |mock_server|
        client.multiplex stream: { newTunnelId: 'bt1' },
                         methods: mock_websocket_client_methods(mock_server, response_data)
      end
    end
  end

  context 'Public topic' do
    let(:request_path) { '/api/v1/bullet-public' }

    context '#ticker' do
      let(:response_data) do
        { 'id' => 981_147_906, 'privateChannel' => false, 'response' => true, 'topic' => '/market/ticker:ETH-BTC',
          'type' => 'subscribe' }
      end

      it 'return valid response' do
        mock_websocket_server do |mock_server|
          client.ticker symbols: market_symbol, methods: mock_websocket_client_methods(mock_server, response_data)
        end
      end

      context 'multiple symbols' do
        let(:response_data) do
          { 'id' => 981_147_906, 'privateChannel' => false, 'response' => true, 'topic' => '/market/ticker:ETH-BTC,KCS-BTC',
            'type' => 'subscribe' }
        end
        let(:market_symbol) { %w[ETH-BTC KCS-BTC] }

        it 'return valid response' do
          mock_websocket_server do |mock_server|
            client.ticker symbols: market_symbol, methods: mock_websocket_client_methods(mock_server, response_data)
          end
        end
      end
    end

    context '#all_ticker' do
      let(:response_data) do
        { 'id' => 981_147_906, 'privateChannel' => false, 'response' => true, 'topic' => '/market/ticker:all',
          'type' => 'subscribe' }
      end

      it 'return valid response' do
        mock_websocket_server do |mock_server|
          client.all_ticker methods: mock_websocket_client_methods(mock_server, response_data)
        end
      end
    end

    context '#snapshot' do
      let(:response_data) do
        { 'id' => 981_147_906, 'privateChannel' => false, 'response' => true, 'topic' => '/market/snapshot:ETH-BTC',
          'type' => 'subscribe' }
      end

      it 'return valid response' do
        mock_websocket_server do |mock_server|
          client.snapshot symbol: market_symbol, methods: mock_websocket_client_methods(mock_server, response_data)
        end
      end
      it { expect(subject.method(:snapshot) == subject.method(:symbol_snapshot)).to be_truthy }
      it { expect(subject.method(:snapshot) == subject.method(:market_snapshot)).to be_truthy }
    end

    context '#level_2_market_data' do
      let(:response_data) do
        { 'id' => 981_147_906, 'privateChannel' => false, 'response' => true, 'topic' => '/market/level2:ETH-BTC',
          'type' => 'subscribe' }
      end

      it 'return valid response' do
        mock_websocket_server do |mock_server|
          client.level_2_market_data symbols: market_symbol,
                                     methods: mock_websocket_client_methods(
                                       mock_server, response_data
                                     )
        end
      end
    end

    context '#match_execution_data' do
      let(:response_data) do
        { 'id' => 981_147_906, 'privateChannel' => false, 'response' => true, 'topic' => '/market/match:ETH-BTC',
          'type' => 'subscribe' }
      end

      it 'return valid response' do
        mock_websocket_server do |mock_server|
          client.match_execution_data symbols: market_symbol,
                                      methods: mock_websocket_client_methods(
                                        mock_server, response_data
                                      )
        end
      end
    end

    context '#full_match_engine_data' do
      let(:response_data) do
        { 'id' => 981_147_906, 'privateChannel' => false, 'response' => true, 'topic' => '/market/level3:ETH-BTC',
          'type' => 'subscribe' }
      end

      it 'return valid response' do
        mock_websocket_server do |mock_server|
          client.full_match_engine_data symbols: market_symbol,
                                        methods: mock_websocket_client_methods(
                                          mock_server, response_data
                                        )
        end
      end
    end

    context 'Private topic' do
      let(:request_path) { '/api/v1/bullet-private' }

      context '#stop_order_received_event' do
        let(:response_data) do
          { 'id' => 981_147_906, 'privateChannel' => true, 'response' => true, 'topic' => '/market/level3:ETH-BTC',
            'type' => 'subscribe' }
        end

        it 'return valid response' do
          mock_websocket_server do |mock_server|
            client.stop_order_received_event symbols: market_symbol,
                                             methods: mock_websocket_client_methods(
                                               mock_server, response_data
                                             )
          end
        end
        it {
          expect(subject.method(:stop_order_received_event) == subject.method(:stop_order_received_event)).to be_truthy
        }
      end

      context '#balance' do
        let(:response_data) do
          { 'id' => 981_147_906, 'privateChannel' => true, 'response' => true, 'topic' => '/account/balance',
            'type' => 'subscribe' }
        end

        it 'return valid response' do
          mock_websocket_server do |mock_server|
            client.balance methods: mock_websocket_client_methods(mock_server, response_data)
          end
        end
      end
    end
  end
end
