module Base58

  BASE = 58    #  ALPHABET.length == 58   ## 58 chars/letters/digits

  class Configuration

     MAPPING = {
       bitcoin:    Bitcoin,
       ## flickr:     Flickr,
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




  def self.encode( num_or_bytes, klass: configuration.format )
    klass.encode( num_or_bytes )
  end

  def self.decode( str_or_bytes, klass: configuration.format )
    klass.decode( str_or_bytes )
  end




  ####
  # (private) helper - note: leading underscore in name e.g. _bytes
  def self._bytes( num )
    b = []
    while num >= BASE
      mod = num % BASE
      b << mod
      num = (num - mod) / BASE
    end
    b << num
    b = b.reverse
    b
  end

  def self._pack( bytes )
    num = 0
    bytes.reverse.each_with_index do |byte,index|
      num += byte * (BASE**(index))
    end
    num
  end

  ## encoding alphabet - letter-to-number by index / array
  def self.alphabet( klass: configuration.format ) klass.alphabet; end

  ## decoding letter-to-number mapping / hash
  def self.number( klass: configuration.format ) klass.number; end
end # module Base58
