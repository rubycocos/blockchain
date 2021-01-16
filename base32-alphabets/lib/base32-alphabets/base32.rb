# encoding: utf-8


module Base32   ## Base32  (2^5 - 5-bits)

  BASE = 32    #  ALPHABET.length == 32   ## 32 chars/letters/digits


  class Configuration
     attr_reader :format

     MAPPING = {
       kai:           Kai,            # starts counting at 1 (one)
       crockford:     Crockford,      # starts counting at 0 (zero)
       hex:           Crockford,      #  note: use hex as an alias - why? why not?
       electrologica: Electrologica,
       num:           Electrologica,  #  note: use num as an alias
     }

     def initialize
       @format = Kai
     end

     def format=(value)
       if value.is_a? Symbol
         @format = MAPPING[ value ]
       else  ## assume class
         @format = value
       end
     end
  end # class Configuration

  ## lets you use
  ##   Base32.configure do |config|
  ##      config.format     =  :kai
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

  def self.fmt( str_or_num_or_bytes, klass: configuration.format, group: 4, sep: ' ' )
    klass.fmt( str_or_num_or_bytes, group: group, sep: sep )
  end

  def self.bytes( num_or_str, klass: configuration.format )
    klass.bytes( num_or_str )
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
  ## decoding letter-to-code mapping / hash
  def self.code( klass: configuration.format ) klass.code; end
  ## decoding letter-to-binary mapping / hash
  def self.binary( klass: configuration.format ) klass.binary; end
end # module Base32
