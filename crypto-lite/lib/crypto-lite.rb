require 'pp'
require 'digest'
require 'base64'
require 'openssl'


## our own code
require 'crypto-lite/version'    # note: let version always go first



module Crypto

  def self.sha256bin( input, engine=nil )   ## todo/check: add alias sha256b or such to - why? why not?
    input_type = if input.is_a?( String )
                  "#{input.class.name}/#{input.encoding}"
                 else
                  input.class.name
                 end
    puts "  input: #{input} (#{input_type})"

    message = if input.is_a?( Integer )  ## assume byte if single (unsigned) integer
                raise ArgumentError, "expected unsigned byte (0-255) - got #{input} (0x#{input.to_s(16)}) - can't pack negative number; sorry"   if input < 0
                ## note: pack -  H (String) => hex string (high nibble first)
                ## todo/check: is there a better way to convert integer number to (binary) string!!!
                [input.to_s(16)].pack('H*')
              else  ## assume (binary) string
                input
              end


       bytes = message.bytes
       bin   = bytes.map {|byte| byte.to_s(2).rjust(8, "0")}.join( ' ' )
       hex   = bytes.map {|byte| byte.to_s(16).rjust(2, "0")}.join( ' ' )
       puts "  #{pluralize( bytes.size, 'byte')}:  #{bytes.inspect}"
       puts "  binary: #{bin}"
       puts "  hex:    #{hex}"

       if engine && ['openssl'].include?( engine.to_s.downcase )
         puts "  engine: #{engine}"
         digest = OpenSSL::Digest::SHA256.new
         digest.update( message )
         digest.digest
       else  ## use "built-in" hash function from digest module
         Digest::SHA256.digest( message )
       end
  end

  def self.sha256( input, engine=nil )
    sha256bin( input, engine ).unpack( 'H*' )[0]
  end


  def self.sha256hex( input, engine=nil )
    ## convenience helper - lets you pass in hex string

    ##  check if input starts with 0x or 0X if yes - (auto-)cut off!!!!!
    if input.start_with?( '0x') || input.start_with?( '0X' )
      input = input[2..-1]
    end

    raise ArgumentError, "expected hex string (0-9a-f) - got >#{input}< - can't pack string; sorry"   if input.downcase =~ /[^0-9a-f]/
    sha256( [input].pack( 'H*' ), engine )
  end



  def self.pluralize( count, noun )
     count == 1 ? "#{count} #{noun}" : "#{count} #{noun}s"
  end



module RSA
  def self.generate_keys  ## todo/check: add a generate alias - why? why not?
    key_pair = OpenSSL::PKey::RSA.new( 2048 )
    private_key = key_pair.export
    public_key  = key_pair.public_key.export

    [private_key, public_key]
  end


  def self.sign( plaintext, private_key )
    private_key = OpenSSL::PKey::RSA.new( private_key ) ## note: convert/wrap into to obj from exported text format
    Base64.encode64( private_key.private_encrypt( plaintext ))
  end

  def self.decrypt( ciphertext, public_key )
    public_key = OpenSSL::PKey::RSA.new( public_key )  ## note: convert/wrap into to obj from exported text format
    public_key.public_decrypt( Base64.decode64( ciphertext ))
  end


  def self.valid_signature?( plaintext, ciphertext, public_key )
    plaintext == decrypt( ciphertext, public_key )
  end
end # module RSA
end # module Crypto




## add convenience "top-level" helpers
def sha256( input, engine=nil )    Crypto.sha256( input, engine ); end
def sha256hex( input, engine=nil ) Crypto.sha256hex( input, engine ); end

RSA = Crypto::RSA






puts CryptoLite.banner    ## say hello
