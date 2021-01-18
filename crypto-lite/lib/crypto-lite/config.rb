module Crypto

  class Configuration

    def initialize
      @debug = false
    end

    def debug?()         @debug || false; end
    def debug=(value)    @debug = value; end
  end # class Configuration

  ## lets you use
  ##   Crypto.configure do |config|
  ##      config.debug  =  true
  ##   end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield( configuration )
  end

  ## add convenience helper for format
  def self.debug?() configuration.debug?; end
  def self.debug=(value) self.configuration.debug = value; end
end # module Crypto



