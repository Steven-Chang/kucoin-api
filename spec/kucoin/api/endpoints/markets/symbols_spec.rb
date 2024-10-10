# frozen_string_literal: true

RSpec.describe Kucoin::Api::Endpoints::Markets::Symbols, type: :endpoint do
  describe '#index' do
    let(:request_path) { '/api/v1/symbols' }
    it { expect(subject.index).to eq({ 'foo' => 'bar' }) }
    context 'with market' do
      let(:request_path) { '/api/v1/symbols?market=ETH' }
      it { expect(subject.index(market: 'ETH')).to eq({ 'foo' => 'bar' }) }
    end
  end
end
