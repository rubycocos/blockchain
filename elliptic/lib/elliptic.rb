require 'pp'
require 'digest'
require 'base64'
require 'openssl'

## our own code
require 'elliptic/version'    # note: let version always go first
require 'elliptic/private_key'
require 'elliptic/public_key'
require 'elliptic/signature'



module EC

  ## "cached" / available groups for now include:
  GROUP = {
    'secp256k1' =>  OpenSSL::PKey::EC::Group.new( 'secp256k1' )
  }


  class Point

    def initialize( *args, group: nil )
      ## case 1) assume OpenSSL::PKey::EC::Point
      if args.size == 1 && args[0].is_a?( OpenSSL::PKey::EC::Point )
         @pt = args[0]

         ## todo/check: is there a "better" way to get the x/y numbers?
         hex = @pt.to_octet_string( :uncompressed ).unpack( 'H*' )[0]

         ## todo/fix: check for infinity / 0 !!!!
         @x = hex[2,64].to_i(16)       ## skip leading 0x04 marker
         @y = hex[2+64,64].to_i(16)
      else  ## assume x,y with group
         ## rebuild openssl point from octet

         @x = args[0]
         @y = args[1]

         ## encoded_point is the octet string representation of the point.
         ## This must be either a String or an OpenSSL::BN
         hex = '04' + ("%064x" % @x) + ("%064x" % @y)
         bin = [hex].pack( 'H*' )

         ec_group = GROUP[ group || 'secp256k1' ]
         @pt = OpenSSL::PKey::EC::Point.new( ec_group, bin )
      end
    end

    def x()  @x; end
    def y()  @y; end
    def group() @pt.group; end

    ## formats - :compressed | :uncompressed
    def to_bin( format=:uncompressed )  ## todo/check add alias .b too - why? why not?
      @pt.to_octet_string( format )
    end

    def to_s( format=:uncompressed )
      to_bin( format ).unpack( 'H*' )[0]
    end

    ## return OpenSSL::PKey::EC::Point - find a better name? e.g. to_raw/native or such - why? why not?
    def to_ec_point()  @pt; end
  end



  def self.sign( message, priv_key )
    signer = PrivateKey.convert( priv_key )
    signer.sign( message )
  end

  def self.verify?( message, signature, pub_key )
    verifier = PublicKey.convert( pub_key )
    verifier.verify?( message, signature )
  end

  class << self
    alias_method :valid_signature?, :verify?
  end




  def self.builtin_curves
    OpenSSL::PKey::EC.builtin_curves
  end
end  ## module EC




puts EC.banner     ## say hello
