require 'pp'
require 'digest'
require 'base64'
require 'openssl'

## our own code
require 'ellipticcurve/version'    # note: let version always go first



module EC



  class Signature

    def self.decode_der( der )
      asn1 = OpenSSL::ASN1.decode(der )
      r = asn1.value[0].value.to_i
      s = asn1.value[1].value.to_i
      new(r, s)
    end

    attr_reader :r, :s
    def initialize(r, s)
      @r, @s = r, s
    end

    def to_der
      asn1 = OpenSSL::ASN1::Sequence.new [
          OpenSSL::ASN1::Integer.new( @r ),
          OpenSSL::ASN1::Integer.new( @s ),
        ]
      asn1.to_der
    end
  end ## class Signature




  ## "cached" / available groups for now include:
  GROUP = {
    ## todo/check: is there a more direct way to get a group object?
    'secp256k1' =>  OpenSSL::PKey::EC.new( 'secp256k1' ).group
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
         prefix = '04'
         hex = prefix + ("%064x" % @x) + ("%064x" % @y)
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
    def to_point()  @pt; end
  end




  class Algo
    def initialize( input=nil, group: nil )

     ## case 1) "restore"  public key (only) from point for verify
     if input.is_a?( OpenSSL::PKey::EC::Point ) ||  ## assume public key only (restore pkey object for verify?)
        input.is_a?( Point )

       point = input.is_a?( Point ) ? input.to_point : input

       ## note: (auto)get group from point
       @pkey = OpenSSL::PKey::EC.new( point.group )
       @pkey.public_key = point
     else  ## case 2) build a private/public key pair

       ec_group = GROUP[ group || 'secp256k1' ]
       @pkey = OpenSSL::PKey::EC.new( ec_group )

       if input.nil?     ## auto-generate new key
         @pkey.generate_key
       else
         num = if input.is_a?( String )
                 input.to_i( 16 )
               else   ## assume (big) integer
                 input
               end
         @pkey.private_key = OpenSSL::BN.new( num )
         ## auto-calculate public key too
         @pkey.public_key = @pkey.group.generator.mul( @pkey.private_key )
       end
      end
    end


    def group() @pkey.group; end

    def public?()   @pkey.public?; end
    def private?()  @pkey.private?; end


    ## todo/check/fix: fix case with no private_key if passed in point/public key for verify!!!
    def private_key() @pkey.private_key.to_i; end
    alias_method :priv_key, :private_key   ## add signing_key alias too?

    def public_key() @public_key ||= Point.new( @pkey.public_key ); end


    def sign( message )
      signature_der = @pkey.dsa_sign_asn1( message )
      Signature.decode_der( signature_der )
    end

    def verify?( message, signature )
      signature_der = signature.to_der
      @pkey.dsa_verify_asn1( message, signature_der )
    end
    alias_method :valid_signature?, :verify?


    def to_text() @pkey.to_text; end
  end



  def self.sign( message, priv_key )
    algo = Algo.new( priv_key )
    algo.sign( message )
  end

  def self.verify?( message, pub_key, signature )
    algo = Algo.new( pub_key )
    algo.verify?( message, signature )
  end

  class << self
    alias_method :valid_signature?, :verify?
  end




  def self.builtin_curves
    OpenSSL::PKey::EC.builtin_curves
  end
end  ## module EC




puts EC.banner     ## say hello
