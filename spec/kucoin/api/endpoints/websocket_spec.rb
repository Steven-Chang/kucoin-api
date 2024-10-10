# frozen_string_literal: true

RSpec.describe Kucoin::Api::Endpoints::Websocket, type: :endpoint do
  let(:request_method) { :post }
  let(:response_body)    do
    {
      "code": '200000',
      "data": {
        "instanceServers": [
          {
            "pingInterval": 50_000,
            "endpoint": 'wss://push1-v2.kucoin.com/endpoint',
            "protocol": 'websocket',
            "encrypt": true,
            "pingTimeout": 10_000
          }
        ],
        "token": 'vYNlCtbz4XNJ1QncwWilJnBtmmfe4geLQDUA62kKJsDChc6I4bRDQc73JfIrlFaVYIAE0Gv2--MROnLAgjVsWkcDq_MuG7qV7EktfCEIphiqnlfpQn4Ybg==.IoORVxR2LmKV7_maOR9xOg=='
      }
    }
  end

  describe '#public' do
    let(:request_path) { '/api/v1/bullet-public' }
    it { expect(subject.public).to be_a_kind_of(described_class::Response) }
    it { expect(subject.public.endpoint).to       eq 'wss://push1-v2.kucoin.com/endpoint' }
    it { expect(subject.public.ping_interval).to  eq 50_000 }
    it {
      expect(subject.public.token).to eq 'vYNlCtbz4XNJ1QncwWilJnBtmmfe4geLQDUA62kKJsDChc6I4bRDQc73JfIrlFaVYIAE0Gv2--MROnLAgjVsWkcDq_MuG7qV7EktfCEIphiqnlfpQn4Ybg==.IoORVxR2LmKV7_maOR9xOg=='
    }
  end

  describe '#private' do
    let(:request_path) { '/api/v1/bullet-private' }
    it { expect(subject.private).to be_a_kind_of(described_class::Response) }
    it { expect(subject.private.endpoint).to       eq 'wss://push1-v2.kucoin.com/endpoint' }
    it { expect(subject.private.ping_interval).to  eq 50_000 }
    it {
      expect(subject.private.token).to eq 'vYNlCtbz4XNJ1QncwWilJnBtmmfe4geLQDUA62kKJsDChc6I4bRDQc73JfIrlFaVYIAE0Gv2--MROnLAgjVsWkcDq_MuG7qV7EktfCEIphiqnlfpQn4Ybg==.IoORVxR2LmKV7_maOR9xOg=='
    }
  end
end
