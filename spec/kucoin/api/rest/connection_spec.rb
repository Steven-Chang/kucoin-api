# frozen_string_literal: true

RSpec.describe Kucoin::Api::REST::Connection do
  let(:endpoint) { Kucoin::Api::Endpoints::Base.new(Kucoin::Api::REST.new) }
  let(:options) { { url: 'http://example.com/' } }
  let(:connection) { described_class.new(endpoint, options) }
  subject { connection }

  describe '#ku_request' do
    let(:endpoint_url)    { 'v1/base/all' }
    let(:request_method)  { :get }
    let(:request_url)     { 'http://example.com' }
    let(:request_body)    { '' }
    let(:response_status) { 200 }
    let(:response_body)   { { code: '200000', success: true, data: { foo: :bar } } }

    before do
      allow(endpoint.client).to receive(:base).and_return(endpoint)
      stub_const('Kucoin::Api::ENDPOINTS', { base: { all: endpoint_url } })

      stub_request(request_method, request_url)
        .with(body: request_body)
        .to_return(status: response_status, body: response_body.to_json)
    end

    context 'get' do
      let(:request_url) { 'http://example.com/v1/base/all?arg1=foo&arg2=bar' }
      context 'valid response' do
        it { expect(subject.ku_request(request_method, :all, arg1: :foo, arg2: :bar)).to eq({ 'foo' => 'bar' }) }

        context 'having path attributes' do
          let(:endpoint_url)    { 'v1/base/:foo/all' }
          let(:request_url)     { 'http://example.com/v1/base/bar/all' }
          it { expect(subject.ku_request(request_method, :all, foo: :bar)).to eq({ 'foo' => 'bar' }) }
        end
      end

      context 'invalid response' do
        context 'not found' do
          let(:response_status) { 404 }
          let(:response_body)   do
            { 'timestamp' => 1_546_519_594_045, 'status' => 404, 'error' => 'Not Found', 'message' => 'No message available',
              'path' => '/account/foo/withdraw/cancel' }
          end

          it {
            expect do
              subject.ku_request(request_method, :all, arg1: :foo,
                                                       arg2: :bar)
            end.to raise_error(Kucoin::Api::ClientError, /404 - No message available/)
          }
        end
        context 'invalid params' do
          let(:response_status) { 404 }
          let(:response_body)   { { "code": '400100', "msg": 'Invalid Parameter.' } }

          it {
            expect do
              subject.ku_request(request_method, :all, arg1: :foo,
                                                       arg2: :bar)
            end.to raise_error(Kucoin::Api::ClientError, /400100 - Invalid Parameter./)
          }
        end
      end
    end

    context 'post' do
      let(:request_method) { :post }
      let(:request_body) { { arg1: 'foo', arg2: 'bar' } }
      let(:request_url) { 'http://example.com/v1/base/all' }

      context 'valid response' do
        it { expect(subject.ku_request(request_method, :all, arg1: :foo, arg2: :bar)).to eq({ 'foo' => 'bar' }) }

        context 'having path attributes' do
          let(:endpoint_url) { 'v1/base/:foo/all' }
          let(:request_url) { 'http://example.com/v1/base/bar/all' }
          it {
            expect(subject.ku_request(request_method, :all, arg1: :foo, arg2: :bar,
                                                            foo: :bar)).to eq({ 'foo' => 'bar' })
          }
        end
      end
    end
  end
end
