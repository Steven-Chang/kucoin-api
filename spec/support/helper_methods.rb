# frozen_string_literal: true

def acquire_websocket_servers_response
  JSON.parse(fixture('acquire_websocket_servers_response.json').read)
end

def fixture(file)
  fixtures_path = File.expand_path('../fixtures', __dir__)
  File.new("#{fixtures_path}/#{file}")
end

def logger
  @logger ||= ::Logger.new('log/test.log')
end
