RSpec.describe Kucoin::Api do
  it "has a version number" do
    expect(Kucoin::Api::VERSION).not_to be nil
  end

  it "has endpoints" do
    expect(Kucoin::Api::ENDPOINTS).to be_a Hash
  end

  describe 'error class' do
    describe 'Error' do
      it { expect(Kucoin::Api::Error.new).to be_kind_of StandardError }
    end

    describe 'MissingApiKeyError' do
      it { expect(Kucoin::Api::MissingApiKeyError.new).to be_kind_of StandardError }
    end

    describe 'MissingApiSecretError' do
      it { expect(Kucoin::Api::MissingApiSecretError.new).to be_kind_of StandardError }
    end

    describe 'MissingApiSecretError' do
      it { expect(Kucoin::Api::MissingApiSecretError.new).to be_kind_of StandardError }
    end
  end
end
