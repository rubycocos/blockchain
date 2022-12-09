require 'pp'
require 'digest'
require 'base64'
require 'openssl'


## our own 3rd party (2nd party?)
require 'digest-lite'  # e.g. keccak (original submission/proposal NOT official sha3)
require 'base32-alphabets'
require 'base58-alphabets'
require 'elliptic'



## our own code
require_relative 'crypto-lite/version'    # note: let version always go first
require_relative 'crypto-lite/config'
require_relative 'crypto-lite/metal'




module Crypto

  def self.base58( *args, **kwargs )
    input = args_to_input( args, kwargs )
    Metal.base58bin( input )
  end

  def self.base58check( *args, **kwargs )
    input = args_to_input( args, kwargs )
    Metal.base58bin_check( input )
  end


  ########################
  # (secure) hash functions

  def self.keccak256( *args, **kwargs )
    input = args_to_input( args, kwargs )
    Metal.keccak256bin( input ).unpack( 'H*' )[0]
  end


  def self.rmd160( *args, **kwargs )
    input = args_to_input( args, kwargs )
    Metal.rmd160bin( input ).unpack( 'H*' )[0]
  end

  ## add alias RIPEMD160 - why? why not?
  class << self
    alias_method :ripemd160,    :rmd160
  end


  def self.sha256( *args, **kwargs )
    input = args_to_input( args, kwargs )
    engine = kwargs[:engine]
    Metal.sha256bin( input, engine ).unpack( 'H*' )[0]
  end

  def self.sha3_256( *args, **kwargs )
    input = args_to_input( args, kwargs )
    Metal.sha3_256bin( input ).unpack( 'H*' )[0]
  end



  def self.hash160( *args, **kwargs )
    input = args_to_input( args, kwargs )
    Metal.hash160bin( input ).unpack( 'H*' )[0]
  end

  def self.hash256( *args, **kwargs )
    input = args_to_input( args, kwargs )
    Metal.hash256bin( input ).unpack( 'H*' )[0]
  end



  ########
  # more helpers
  ## check if it is a hex (string)
  ##  - allow optiona 0x or 0X  and allow abcdef and ABCDEF
  HEX_RE = /\A(?:0x)?[0-9a-f]+\z/i

  def self.args_to_input( args, kwargs )
    if kwargs[:hex]
      hex = kwargs[:hex]
      raise ArgumentError, "expected hex string (0-9a-f) - got >#{hex}< - can't pack string; sorry"   unless hex =~ HEX_RE

      hex = strip0x( hex )  ##  check if input starts with 0x or 0X if yes - (auto-)cut off!!!!!
      [hex].pack( 'H*' )
    else   ## assume single input arg for now
      input = args[0]
      input = hex_to_bin_automagic( input )  ## add automagic hex (string) to bin (string) check - why? why not?
      input
    end
  end

  def self.hex_to_bin_automagic( input )
    ## todo/check/fix: add configure setting to turn off automagic - why? why not?
     if input.is_a?( String ) && input =~ HEX_RE
        if input[0,2] == '0x' || input[0,2] == '0X'
          ## starting with 0x or 0X always assume hex string for now - why? why not?
          input = input[2..-1]
          [input].pack( 'H*' )
        elsif input.size >= 10
          ## note: hex heuristic!!
          ##   for now assumes string MUST have more than 10 digits to qualify!!!
          [input].pack( 'H*' )
        else
          input ## pass through as is!!! (e.g.   a, abc, etc.)
        end
     else
          input  ## pass through as is
     end
  end


  def self.strip0x( str )    ## todo/check: add alias e.g. strip_hex_prefix or such - why? why not?
    (str[0,2] == '0x' || str[0,2] == '0X') ?  str[2..-1] : str
  end

#  def self.hex_to_bin( str )
#    str = strip0x( str )  ##  check if input starts with 0x or 0X if yes - (auto-)cut off!!!!!
#    [str].pack( 'H*' )
#  end

end # module Crypto




require_relative 'crypto-lite/helper'
include CryptoHelper      # add convenience "top-level" / global helpers


require_relative 'crypto-lite/sign_rsa'
RSA = Crypto::RSA




puts CryptoLite.banner    ## say hello
