# frozen_string_literal: true

RSpec.describe Kucoin::Api::Endpoints::Markets::OrderBook, type: :endpoint do
  describe '#part' do
    let(:request_path) { '/api/v1/market/orderbook/level2_20?symbol=BTC-USDT' }
    it { expect(subject.part('BTC-USDT', '20')).to eq({ 'foo' => 'bar' }) }
    context '100' do
      let(:request_path) { '/api/v1/market/orderbook/level2_100?symbol=BTC-USDT' }
      it { expect(subject.part('BTC-USDT', '100')).to eq({ 'foo' => 'bar' }) }
    end
    context 'in valid depth' do
      it { expect { subject.part('BTC-USDT', 'foo') }.to raise_error(Kucoin::Api::InvalidParamError) }
    end
  end

  describe '#full_aggregated' do
    let(:request_path) { '/api/v2/market/orderbook/level2?symbol=BTC-USDT' }
    it { expect(subject.full_aggregated('BTC-USDT')).to eq({ 'foo' => 'bar' }) }
  end

  describe '#full_atomic' do
    let(:request_path) { '/api/v1/market/orderbook/level3?symbol=BTC-USDT' }
    it { expect(subject.full_atomic('BTC-USDT')).to eq({ 'foo' => 'bar' }) }
  end
end
