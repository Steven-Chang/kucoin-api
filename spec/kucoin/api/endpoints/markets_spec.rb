# frozen_string_literal: true

RSpec.describe Kucoin::Api::Endpoints::Markets, type: :endpoint do
  describe '#index' do
    let(:request_path) { '/api/v1/markets' }
    it { expect(subject.index).to eq({ 'foo' => 'bar' }) }
    it { expect(subject.method(:index) == subject.method(:all)).to be_truthy }
  end

  describe '#all' do
    let(:request_path) { '/api/v1/markets' }
    it { expect(subject.all).to eq({ 'foo' => 'bar' }) }
  end

  describe '#stats' do
    let(:request_path) { '/api/v1/market/stats?symbol=BTC-USDT' }
    it { expect(subject.stats('BTC-USDT')).to eq({ 'foo' => 'bar' }) }
  end
end
