# frozen_string_literal: true

RSpec.describe Kucoin::Api::Endpoints::Other, type: :endpoint do
  describe '#timestamp' do
    let(:request_path) { '/api/v1/timestamp' }
    it { expect(subject.timestamp).to eq({ 'foo' => 'bar' }) }
  end
end
