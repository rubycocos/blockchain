# encoding: utf-8
# frozen_string_literal: true

module BlockchainLite
  # format <MAJOR>.<MINOR>.<PATCH>
  VERSION = '1.1.0'

  def self.version
    VERSION
  end

  def self.banner
    "blockchain-lite/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

  def self.root
    File.expand_path(File.dirname(File.dirname(File.dirname(__FILE__)))).to_s
  end
end
