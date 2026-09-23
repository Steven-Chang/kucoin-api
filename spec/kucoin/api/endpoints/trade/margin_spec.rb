# frozen_string_literal: true

RSpec.describe Kucoin::Api::Endpoints::Trade::Margin, type: :endpoint do
  describe '#isolated_account' do
    let(:request_path) { '/api/v1/isolated/account/BTC-USDT' }
    it { expect(subject.isolated_account('BTC-USDT')).to eq({ 'foo' => 'bar' }) }
  end

  describe '#isolated_accounts' do
    let(:request_path) { '/api/v3/isolated/accounts?symbol=BTC-USDT' }
    it { expect(subject.isolated_accounts(symbol: 'BTC-USDT')).to eq({ 'foo' => 'bar' }) }
  end
end
