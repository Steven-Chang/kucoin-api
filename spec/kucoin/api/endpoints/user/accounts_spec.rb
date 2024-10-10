# frozen_string_literal: true

RSpec.describe Kucoin::Api::Endpoints::User::Accounts, type: :endpoint do
  describe '#create' do
    let(:request_path)    { '/api/v1/accounts' }
    let(:request_method)  { :post }
    let(:request_body)    { '{"currency":"ETH","type":"trade"}' }
    it { expect(subject.create('ETH', 'trade')).to eq({ 'foo' => 'bar' }) }
  end

  describe '#index' do
    let(:request_path) { '/api/v1/accounts' }
    it { expect(subject.index).to eq({ 'foo' => 'bar' }) }
    it { expect(subject.method(:index) == subject.method(:all)).to be_truthy }
    it { expect(subject.method(:index) == subject.method(:list)).to be_truthy }
  end

  describe '#inner_transfer' do
    let(:request_path)    { '/api/v1/accounts/inner-transfer' }
    let(:request_method)  { :post }
    let(:request_body)    do
      '{"clientOid":"t1","payAccountId":"payId","recAccountId":"recId","amount":10}'
    end
    it { expect(subject.inner_transfer('t1', 'payId', 'recId', 10)).to eq({ 'foo' => 'bar' }) }
  end

  describe '#show' do
    let(:request_path) { '/api/v1/accounts/123' }
    it { expect(subject.show(123)).to eq({ 'foo' => 'bar' }) }
    it { expect(subject.method(:show) == subject.method(:get)).to be_truthy }
    it { expect(subject.method(:show) == subject.method(:detail)).to be_truthy }
  end

  describe '#ledgers' do
    let(:request_path) { '/api/v1/accounts/123/ledgers' }
    it { expect(subject.ledgers(123)).to eq({ 'foo' => 'bar' }) }
  end

  describe '#holds' do
    let(:request_path) { '/api/v1/accounts/123/holds' }
    it { expect(subject.holds(123)).to eq({ 'foo' => 'bar' }) }
  end
end
