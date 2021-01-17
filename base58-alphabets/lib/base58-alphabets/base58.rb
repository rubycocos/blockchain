module Base58

  class Configuration

     MAPPING = {
       bitcoin:    Bitcoin,
       flickr:     Flickr,
     }

     attr_reader :format

     def initialize
       @format = Bitcoin
     end

     def format=(value)
       if value.is_a?( Symbol )
         @format = MAPPING[ value ]
       else  ## assume class
         @format = value
       end
     end
  end # class Configuration

  ## lets you use
  ##   Base58.configure do |config|
  ##      config.format     =  :bitcoin
  ##   end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield( configuration )
  end

  ## add convenience helper for format
  def self.format() configuration.format; end
  def self.format=(value) self.configuration.format = value; end




  def self.encode_num( num,  klass: configuration.format ) klass.encode_num( num );  end
  def self.encode_bin( data, klass: configuration.format ) klass.encode_bin( data ); end
  def self.encode_hex( str,  klass: configuration.format ) klass.encode_hex( str );  end

  def self.decode_num( str,  klass: configuration.format ) klass.decode_num( str ); end
  def self.decode_bin( str,  klass: configuration.format ) klass.decode_bin( str ); end
  def self.decode_hex( str,  klass: configuration.format ) klass.decode_hex( str ); end



  ## encoding alphabet - letter-to-number by index / array
  def self.alphabet( klass: configuration.format ) klass.alphabet; end

  ## decoding letter-to-number mapping / hash
  def self.number( klass: configuration.format ) klass.number; end
end # module Base58
