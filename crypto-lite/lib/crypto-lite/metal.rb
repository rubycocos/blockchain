module Crypto
module Metal

  def self.debug?()  Crypto.debug?; end

  ########################
  ### to the "metal" crypto primitives
  ##    work with binary strings (aka byte arrays) / data

  ##
  ## todo/check: use/keep bin-suffix in name - why? why not?


  def self.base58bin( input )
    ## todo/check: input must be a (binary) string - why? why not?
    Base58::Bitcoin.encode_bin( input )
  end

  def self.base58bin_check( input )
    ## todo/check: input must be a (binary) string - why? why not?
    hash256 = hash256bin( input )
    base58bin( input + hash256[0,4] )
  end


  ########################
  # (secure) hash functions

  def self.keccak256bin( input )
    message = message( input )   ## "normalize" / convert to (binary) string
    Digest::KeccakLite.digest( message, 256 )
  end

  def self.rmd160bin( input )
    message = message( input )   ## "normalize" / convert to (binary) string
    Digest::RMD160.digest( message )
  end

  ## add alias RIPEMD160 - why? why not?
  class << self
    alias_method :ripemd160bin, :rmd160bin
  end


  def self.sha256bin( input, engine=nil )   ## todo/check: add alias sha256b or such to - why? why not?
    message = message( input )  ## "normalize" / convert to (binary) string

    if engine && ['openssl'].include?( engine.to_s.downcase )
      puts "  engine: #{engine}"    if debug?
      digest = OpenSSL::Digest::SHA256.new
      ## or use OpenSSL::Digest.new( 'SHA256' )
      digest.update( message )
      digest.digest
    else  ## use "built-in" hash function from digest module
      Digest::SHA256.digest( message )
    end
  end


  def self.sha3_256bin( input, engine=nil )
    message = message( input )  ## "normalize" / convert to (binary) string

    if engine && ['openssl'].include?( engine.to_s.downcase )
      puts "  engine: #{engine}"    if debug?
      digest = OpenSSL::Digest.new( 'SHA3-256' )
      digest.update( message )
      digest.digest
    else  ## use "built-in" hash function from digest module
      Digest::SHA3Lite.digest( message, 256 )
    end
  end


  ####
  ## helper
  # def hash160( pubkey )
  #  binary    = [pubkey].pack( "H*" )       # Convert to binary first before hashing
  #  sha256    = Digest::SHA256.digest( binary )
  #  ripemd160 = Digest::RMD160.digest( sha256 )
  #              ripemd160.unpack( "H*" )[0]    # Convert back to hex
  # end

  def self.hash160bin( input )
    message = message( input )   ## "normalize" / convert to (binary) string

    rmd160bin(sha256bin( message ))
  end


  def self.hash256bin( input )
    message = message( input )   ## "normalize" / convert to (binary) string

    sha256bin(sha256bin( message ))
  end


  ##############################
  ## helpers
  def self.message( input )  ## convert input to (binary) string
    if debug?
      input_type = if input.is_a?( String )
                    "#{input.class.name}/#{input.encoding}"
                   else
                    input.class.name
                   end
      puts "  input: #{input} (#{input_type})"
    end

    message = if input.is_a?( Integer )  ## assume byte if single (unsigned) integer
                raise ArgumentError, "expected unsigned byte (0-255) - got #{input} (0x#{input.to_s(16)}) - can't pack negative number; sorry"   if input < 0
                ## note: pack -  H (String) => hex string (high nibble first)
                ## todo/check: is there a better way to convert integer number to (binary) string!!!
                [input.to_s(16)].pack('H*')
              else  ## assume (binary) string
                input
              end

    if debug?
      bytes = message.bytes
      bin   = bytes.map {|byte| byte.to_s(2).rjust(8, "0")}.join( ' ' )
      hex   = bytes.map {|byte| byte.to_s(16).rjust(2, "0")}.join( ' ' )
      puts "  #{pluralize( bytes.size, 'byte')}:  #{bytes.inspect}"
      puts "  binary: #{bin}"
      puts "  hex:    #{hex}"
    end

    message
  end

  def self.pluralize( count, noun )
    count == 1 ? "#{count} #{noun}" : "#{count} #{noun}s"
  end

end   # module Metal
end   # module Crypto
