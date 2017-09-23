# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blockchain-lite/version'

Gem::Specification.new do |spec|
  spec.name          = 'blockchain-lite'
  spec.version       = BlockchainLite::VERSION
  spec.authors       = ['Gerald Bauer']
  spec.email         = ['gerald.bauer@gmail.com']

  spec.summary       = 'build your own blockchain with crypto hashes'
  spec.description   = 'build your own blockchain with crypto hashes - revolutionize the world with blockchains, blockchains, blockchains one block at a time'
  spec.homepage      = 'https://github.com/openblockchains/blockchain.lite.rb'
  spec.license       = 'Public Domain'

  spec.required_ruby_version = '>= 2.3.0'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pp'
end
