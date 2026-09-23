# frozen_string_literal: true

RSpec.describe Kucoin::Api::Endpoints::User::Deposits, type: :endpoint do
  describe '#create' do
    let(:request_path)    { '/api/v1/deposit-addresses' }
    let(:request_method)  { :post }
    let(:request_body)    { '{"currency":"ETH"}' }
    it { expect(subject.create('ETH')).to eq({ 'foo' => 'bar' }) }
  end

  describe '#create_v3' do
    let(:request_path)    { '/api/v3/deposit-address/create' }
    let(:request_method)  { :post }
    let(:request_body)    { '{"currency":"TON","chain":"ton"}' }
    it { expect(subject.create_v3('TON', 'ton')).to eq({ 'foo' => 'bar' }) }
  end

  describe '#index' do
    let(:request_path) { '/api/v1/deposits' }
    it { expect(subject.index).to eq({ 'foo' => 'bar' }) }
    it { expect(subject.method(:index) == subject.method(:all)).to be_truthy }
    it { expect(subject.method(:index) == subject.method(:list)).to be_truthy }
  end

  describe '#show' do
    let(:request_path) { '/api/v1/deposit-addresses?currency=123' }
    it { expect(subject.show(123)).to eq({ 'foo' => 'bar' }) }
    it { expect(subject.method(:show) == subject.method(:get)).to be_truthy }
    it { expect(subject.method(:show) == subject.method(:detail)).to be_truthy }
  end

  describe '#show_v3' do
    let(:request_path) { '/api/v3/deposit-addresses?currency=USDT' }
    it { expect(subject.show_v3('USDT')).to eq({ 'foo' => 'bar' }) }
    it { expect(subject.method(:show_v3) == subject.method(:get_v3)).to be_truthy }
  end
end
