# frozen_string_literal: true

RSpec.describe Kucoin::Api::REST do
  let(:client) { described_class.new }
  let(:endpoint) { Kucoin::Api::Endpoints::Base.new(client) }
  subject { client }

  it { expect(described_class::BASE_URL).to eq 'https://openapi-v2.kucoin.com' }
  it { expect(described_class::SANDBOX_BASE_URL).to eq 'https://openapi-sandbox.kucoin.com' }

  describe 'endpoint_methods' do
    Kucoin::Api::ENDPOINTS.each_key do |endpoint_name|
      it endpoint_name.to_s do
        expect(subject.public_send(endpoint_name)).to be_a Kucoin::Api::Endpoints.get_klass(endpoint_name, nil)
        expect(subject.public_send(endpoint_name).client).to eq subject
      end
    end

    Kucoin::Api::ENDPOINTS[:user].each_key do |endpoint_name|
      it endpoint_name.to_s do
        expect(subject.public_send(:user).public_send(endpoint_name)).to be_a Kucoin::Api::Endpoints.get_klass(
          endpoint_name, Kucoin::Api::Endpoints::User
        )
        expect(subject.public_send(:user).public_send(endpoint_name).client).to eq subject
      end
    end

    Kucoin::Api::ENDPOINTS[:trade].each_key do |endpoint_name|
      it endpoint_name.to_s do
        expect(subject.public_send(:trade).public_send(endpoint_name)).to be_a Kucoin::Api::Endpoints.get_klass(
          endpoint_name, Kucoin::Api::Endpoints::Trade
        )
        expect(subject.public_send(:trade).public_send(endpoint_name).client).to eq subject
      end
    end

    Kucoin::Api::ENDPOINTS[:markets].select { |_x, v| v.is_a?(Hash) }.each_key do |endpoint_name|
      it endpoint_name.to_s do
        expect(subject.public_send(:markets).public_send(endpoint_name)).to be_a Kucoin::Api::Endpoints.get_klass(
          endpoint_name, Kucoin::Api::Endpoints::Markets
        )
        expect(subject.public_send(:markets).public_send(endpoint_name).client).to eq subject
      end
    end
  end

  describe '#base_url' do
    it { expect(subject.base_url).to eq described_class::BASE_URL }
    it { expect(subject.sandbox?).to be_falsey }
    describe 'for sandbox' do
      let(:client) { described_class.new(sandbox: true) }
      it { expect(subject.base_url).to eq described_class::SANDBOX_BASE_URL }
      it { expect(subject.sandbox?).to be_truthy }
    end
  end

  describe '#open' do
    it do
      expect(Kucoin::Api::REST::Connection).to receive(:new).with(endpoint,
                                                                  url: Kucoin::Api::REST::BASE_URL).and_call_original
      connection = subject.open(endpoint)
      expect(connection.client.builder.handlers).to include(FaradayMiddleware::EncodeJson, FaradayMiddleware::ParseJson)
    end
  end

  describe '#auth' do
    let(:client) { described_class.new(api_key: 'foo', api_secret: 'bar') }
    it do
      expect(Kucoin::Api::REST::Connection).to receive(:new).with(endpoint,
                                                                  url: Kucoin::Api::REST::BASE_URL).and_call_original
      connection = subject.auth(endpoint)
      expect(connection.client.builder.handlers).to include(FaradayMiddleware::EncodeJson,
                                                            FaradayMiddleware::ParseJson, Kucoin::Api::Middleware::NonceRequest, Kucoin::Api::Middleware::AuthRequest)
    end
  end
end
