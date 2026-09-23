# frozen_string_literal: true

RSpec.describe Kucoin::Api::Endpoints::User::Withdrawals, type: :endpoint do
  describe '#create' do
    let(:request_path)    { '/api/v1/withdrawals' }
    let(:request_method)  { :post }
    let(:request_body)    { '{"currency":"ETH","address":"A1","amount":10}' }
    it { expect(subject.create('ETH', 'A1', 10)).to eq({ 'foo' => 'bar' }) }
    it { expect(subject.method(:create) == subject.method(:apply)).to be_truthy }
  end

  describe '#create_v3' do
    let(:request_path)    { '/api/v3/withdrawals' }
    let(:request_method)  { :post }
    let(:request_body)    do
      '{"currency":"USDT","toAddress":"Taddr","amount":3,"chain":"trx","withdrawType":"ADDRESS"}'
    end
    it { expect(subject.create_v3('USDT', 'Taddr', 3, 'trx')).to eq({ 'foo' => 'bar' }) }
    it { expect(subject.method(:create_v3) == subject.method(:apply_v3)).to be_truthy }
  end

  describe '#index' do
    let(:request_path) { '/api/v1/withdrawals' }
    it { expect(subject.index).to eq({ 'foo' => 'bar' }) }
    it { expect(subject.method(:index) == subject.method(:all)).to be_truthy }
    it { expect(subject.method(:index) == subject.method(:list)).to be_truthy }
  end

  describe '#quotas' do
    let(:request_path) { '/api/v1/withdrawals/quotas?currency=123' }
    it { expect(subject.quotas(123)).to eq({ 'foo' => 'bar' }) }
  end

  describe '#show' do
    let(:request_path) { '/api/v1/withdrawals/123' }
    it { expect(subject.show(123)).to eq({ 'foo' => 'bar' }) }
    it { expect(subject.method(:show) == subject.method(:get)).to be_truthy }
  end

  describe '#delete' do
    let(:request_path)    { '/api/v1/withdrawals/123' }
    let(:request_method)  { :delete }
    it { expect(subject.delete(123)).to eq({ 'foo' => 'bar' }) }
  end
end
