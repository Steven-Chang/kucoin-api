# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kucoin/api/version'

Gem::Specification.new do |spec|
  spec.name          = 'kucoin-api'
  spec.version       = Kucoin::Api::VERSION
  spec.authors       = ['Michael Lang']
  spec.email         = ['mwlang@cybrains.net']

  spec.summary       = 'Implements Kucoin 2.0 API and Websocket'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/mwlang/kucoin-api'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'faraday', '~> 0.15'
  spec.add_runtime_dependency 'faraday_middleware', '~> 0.12'
  spec.add_runtime_dependency 'faye-websocket', '~> 0.10'

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock', '~> 3.5'
end
