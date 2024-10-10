# frozen_string_literal: true

require 'json'
require 'faraday'
require 'faraday_middleware'
require 'faye/websocket'

require 'kucoin/api/version'
require 'kucoin/api/error'

require 'kucoin/api/middleware/auth_request'
require 'kucoin/api/middleware/nonce_request'

require 'kucoin/api/websocket'

require 'kucoin/api/endpoints'

require 'kucoin/api/rest'
require 'kucoin/api/rest/connection'

module Kucoin
  module Api
    def self.default_key
      ENV['KUCOIN_API_KEY'].to_s
    end

    def self.default_secret
      ENV['KUCOIN_API_SECRET'].to_s
    end

    def self.default_passphrase
      ENV['KUCOIN_API_PASSPHRASE'].to_s
    end
  end
end
