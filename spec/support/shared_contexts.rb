# frozen_string_literal: true

RSpec.shared_context 'endpoint', shared_context: :metadata do
  let(:client) { Kucoin::Api::REST.new(api_key: 'foo', api_secret: 'bar', api_passphrase: 'passphrase') }
  let(:endpoint) { described_class.new(client) }
  subject { endpoint }

  let(:endpoint_url)    { 'v1/base/all' }
  let(:auth_request)    { false }

  let(:request_method)  { :get }
  let(:request_path)    { 'http://example.com' }
  let(:request_url)     { "#{Kucoin::Api::REST::BASE_URL}#{request_path}" }
  let(:request_body)    { nil }
  let(:request_headers) do
    if auth_request
      args = { 'Kc-Api-Timestamp' => /.*/, 'Kc-Api-Key' => 'foo', 'Kc-Api-Sign' => /.*/, 'Kc-Api-Passphrase' => /.*/ }
      args['Content-Type'] = 'application/json' if request_method == :post
      args
    end
  end
  let(:request_args) do
    args = {}
    args[:body] = request_body if request_body
    args[:headers] = request_headers if request_headers
    args
  end

  let(:response_status) { 200 }
  let(:response_body)   { { code: 200_000, success: true, data: { foo: :bar } } }

  before do
    if request_args.empty?
      stub_request(request_method, request_url).to_return(status: response_status, body: response_body.to_json)
    else
      stub_request(request_method, request_url).with(request_args).to_return(status: response_status,
                                                                             body: response_body.to_json)
    end
  end
end

RSpec.configure do |rspec|
  rspec.include_context 'endpoint', type: :endpoint
end
