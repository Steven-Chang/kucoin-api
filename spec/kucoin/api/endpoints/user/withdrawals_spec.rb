# frozen_string_literal: true

RSpec.describe Kucoin::Api::Endpoints::User::Withdrawals, type: :endpoint do
  describe '#create' do
    let(:request_path)    { '/api/v1/withdrawals' }
    let(:request_method)  { :post }
    let(:request_body)    { '{"currency":"ETH","address":"A1","amount":10}' }
    it { expect(subject.create('ETH', 'A1', 10)).to eq({ 'foo' => 'bar' }) }
    it { expect(subject.method(:create) == subject.method(:apply)).to be_truthy }
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

  describe '#delete' do
    let(:request_path)    { '/api/v1/withdrawals/123' }
    let(:request_method)  { :delete }
    it { expect(subject.delete(123)).to eq({ 'foo' => 'bar' }) }
  end
end
