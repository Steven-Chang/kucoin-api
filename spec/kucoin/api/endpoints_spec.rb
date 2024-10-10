# frozen_string_literal: true

RSpec.describe Kucoin::Api::Endpoints do
  describe '#get_klass' do
    it { expect(described_class.get_klass('user')).to eq Kucoin::Api::Endpoints::User }
    it { expect(described_class.get_klass(:user)).to eq Kucoin::Api::Endpoints::User }
    it {
      expect(described_class.get_klass('accounts',
                                       Kucoin::Api::Endpoints::User)).to eq Kucoin::Api::Endpoints::User::Accounts
    }
    it {
      expect(described_class.get_klass(:accounts,
                                       Kucoin::Api::Endpoints::User)).to eq Kucoin::Api::Endpoints::User::Accounts
    }
  end
end
