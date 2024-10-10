# frozen_string_literal: true

RSpec.describe Kucoin::Api::Middleware::NonceRequest do
  let(:middleware) { described_class.new(->(env) { env }) }
  let(:env) { Faraday::Env.from({ request_headers: Faraday::Utils::Headers.new }) }
  subject { middleware }

  before do
    allow(DateTime).to receive(:now).and_return(DateTime.new(2001, 2, 3, 4, 5, 6, '+7'))
    subject.call(env)
  end

  it 'add NONCE' do
    expect(env[:request_headers]['KC-API-TIMESTAMP']).to eq '981147906000'
  end
end
