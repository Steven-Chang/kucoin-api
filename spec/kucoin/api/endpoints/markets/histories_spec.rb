# frozen_string_literal: true

RSpec.describe Kucoin::Api::Endpoints::Markets::Histories, type: :endpoint do
  describe '#trade' do
    let(:request_path) { '/api/v1/market/histories?symbol=BTC-USDT' }
    it { expect(subject.trade('BTC-USDT')).to eq({ 'foo' => 'bar' }) }
  end

  describe '#fiat' do
    let(:request_path) { '/api/v1/market/candles?symbol=BTC-USDT&type=1week' }
    it { expect(subject.klines('BTC-USDT', '1week')).to eq({ 'foo' => 'bar' }) }
  end
end
