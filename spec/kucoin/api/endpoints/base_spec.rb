# frozen_string_literal: true

RSpec.describe Kucoin::Api::Endpoints::Base do
  let(:client) { Kucoin::Api::REST.new }
  let(:endpoint) { described_class.new(client) }
  subject { endpoint }

  it { expect(subject.client).to eq client }
  context '#open' do
    it {
      expect(client).to receive(:open).with(subject)
      subject.open
    }
  end

  context '#auth' do
    it {
      expect(client).to receive(:auth).with(subject)
      subject.auth
    }
  end

  context '#path' do
    it { expect(subject.path).to eq 'base' }
    context 'underscore class name' do
      let(:endpoint) { Kucoin::Api::Endpoints::Markets::OrderBook.new(client) }
      it { expect(subject.path).to eq 'markets::order_book' }
    end
  end

  context '#url' do
    before do
      stub_const('Kucoin::Api::ENDPOINTS', { base: { foo: 'v1/foo' } })
    end
    it { expect(subject.url(:foo)).to eq 'v1/foo' }
    it { expect(subject.url(:bar)).to be_nil }
  end

  context '#assert_required_param' do
    it { expect(subject.assert_required_param({ foo: 'bar' }, :foo)).to be_nil }
    it {
      expect do
        subject.assert_required_param({ foo: 'bar' },
                                      :bar)
      end.to raise_error Kucoin::Api::MissingParamError, 'bar is required'
    }
  end

  context '#assert_param_is_one_of' do
    it { expect(subject.assert_param_is_one_of({ foo: 'bar' }, :foo, ['bar'])).to be_nil }
    it {
      expect do
        subject.assert_param_is_one_of({ foo: 'bar' }, :foo,
                                       ['bar-new'])
      end.to raise_error Kucoin::Api::InvalidParamError, 'foo must be one of ["bar-new"]'
    }
  end
end
