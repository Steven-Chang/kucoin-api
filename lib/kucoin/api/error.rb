# frozen_string_literal: true

module Kucoin
  module Api
    class Error < StandardError; end
    class MissingApiKeyError < StandardError; end
    class MissingApiSecretError < StandardError; end
    class MissingApiPassphraseError < StandardError; end
    class ClientError < StandardError; end
    class MissingParamError < StandardError; end
    class InvalidParamError < StandardError; end
  end
end
