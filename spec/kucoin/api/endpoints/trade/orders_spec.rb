# frozen_string_literal: true

RSpec.describe Kucoin::Api::Endpoints::Trade::Orders, type: :endpoint do
  describe '#index' do
    let(:request_path) { '/api/v1/orders' }
    it { expect(subject.index).to eq({ 'foo' => 'bar' }) }
    it { expect(subject.method(:index) == subject.method(:all)).to be_truthy }
    it { expect(subject.method(:list) == subject.method(:all)).to be_truthy }
  end

  describe '#hf_active' do
    let(:request_path) { '/api/v1/hf/orders/active/page?symbol=BTC-USDT' }
    it { expect(subject.hf_active('BTC-USDT')).to eq({ 'foo' => 'bar' }) }
  end

  describe '#hf_closed' do
    let(:request_path) { '/api/v1/hf/orders/done?symbol=BTC-USDT' }
    it { expect(subject.hf_closed('BTC-USDT')).to eq({ 'foo' => 'bar' }) }
  end

  describe '#delete_all' do
    let(:request_path)    { '/api/v1/orders' }
    let(:request_method)  { :delete }
    it { expect(subject.delete_all).to eq({ 'foo' => 'bar' }) }
    it { expect(subject.method(:delete_all) == subject.method(:cancel_all)).to be_truthy }
  end

  describe '#recent' do
    let(:request_path) { '/api/v1/limit/orders' }
    it { expect(subject.recent).to eq({ 'foo' => 'bar' }) }
  end

  describe '#create' do
    let(:request_path)    { '/api/v1/orders' }
    let(:request_method)  { :post }
    let(:request_body)    do
      '{"clientOid":"client_oid1","side":"buy","symbol":"ETH-BTC","price":0.000001,"size":0.032411}'
    end
    it {
      expect(subject.place('client_oid1', 'buy', 'ETH-BTC', price: 0.000001, size: 0.032411)).to eq({ 'foo' => 'bar' })
    }
    it { expect(subject.method(:create) == subject.method(:place)).to be_truthy }
  end

  describe '#hf_create' do
    let(:request_path)    { '/api/v1/hf/orders' }
    let(:request_method)  { :post }
    let(:request_body)    { '{"symbol":"BTC-USDT","side":"buy","type":"limit","price":"50000","size":"0.00001"}' }
    it {
      expect(subject.hf_place('BTC-USDT', 'buy', 'limit', price: '50000', size: '0.00001')).to eq({ 'foo' => 'bar' })
    }
    it { expect(subject.method(:hf_create) == subject.method(:hf_place)).to be_truthy }
  end

  describe '#show' do
    let(:request_path) { '/api/v1/orders/123' }
    it { expect(subject.show(123)).to eq({ 'foo' => 'bar' }) }
    it { expect(subject.method(:show) == subject.method(:get)).to be_truthy }
    it { expect(subject.method(:show) == subject.method(:detail)).to be_truthy }
  end

  describe '#delete' do
    let(:request_path)    { '/api/v1/orders/123' }
    let(:request_method)  { :delete }
    it { expect(subject.delete(123)).to eq({ 'foo' => 'bar' }) }
    it { expect(subject.method(:delete) == subject.method(:cancel)).to be_truthy }
  end

  describe '#hf_show' do
    let(:request_path) { '/api/v1/hf/orders/123?symbol=BTC-USDT' }
    it { expect(subject.hf_show(123, 'BTC-USDT')).to eq({ 'foo' => 'bar' }) }
    it { expect(subject.method(:hf_show) == subject.method(:hf_get)).to be_truthy }
  end

  describe '#hf_delete' do
    let(:request_path)    { '/api/v1/hf/orders/123?symbol=BTC-USDT' }
    let(:request_method)  { :delete }
    it { expect(subject.hf_delete(123, 'BTC-USDT')).to eq({ 'foo' => 'bar' }) }
    it { expect(subject.method(:hf_delete) == subject.method(:hf_cancel)).to be_truthy }
  end
end
