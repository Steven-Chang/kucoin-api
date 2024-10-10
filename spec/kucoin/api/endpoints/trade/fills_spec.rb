# frozen_string_literal: true

RSpec.describe Kucoin::Api::Endpoints::Trade::Fills, type: :endpoint do
  describe '#index' do
    let(:request_path) { '/api/v1/fills' }
    it { expect(subject.index).to eq({ 'foo' => 'bar' }) }
    it { expect(subject.method(:index) == subject.method(:all)).to be_truthy }
    it { expect(subject.method(:list) == subject.method(:all)).to be_truthy }
  end

  describe '#recent' do
    let(:request_path) { '/api/v1/limit/fills' }
    it { expect(subject.recent).to eq({ 'foo' => 'bar' }) }
  end
end
