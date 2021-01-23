require 'pp'
require 'digest'
require 'base64'
require 'openssl'

## our own code
require 'elliptic/version'    # note: let version always go first



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




  class PublicKey
    def self.convert( *args, **kwargs )
      if args.size==1 && args[0].is_a?( PublicKey )
        args[0]   ## pass through as is (already a public key)
      else
        new( *args, group: kwargs[:group] )
      end
    end



    def initialize( *args, group: nil )
      point = if args.size == 2   ## assume (x,y) raw integer points
                 @pt = Point.new( *args, group: group )
                 @pt.to_ec_point ## convert point to openssl (native) class
              else
                ##  "restore"  public key (only) from point for verify
                ## - OpenSSL::PKey::EC::Point   ## assume public key only (restore pkey object for verify?)
                ## - Point
                if args[0].is_a?( Point )
                  @pt = args[0]
                  @pt.to_ec_point
                else
                  args[0]  ## assume it is already OpenSSL::PKey::EC::Point
                end
              end

      ## note: (auto)get group from point
      @pkey = OpenSSL::PKey::EC.new( point.group )
      @pkey.public_key = point
    end

    def group() @pkey.group; end


    def point
      ## cache returned point - why? why not?
      @pt ||= Point.new( @pkey.public_key )
      @pt
    end



    def verify?( message, signature )
      signature_der = signature.to_der
      @pkey.dsa_verify_asn1( message, signature_der )
    end
    alias_method :valid_signature?, :verify?

    ## helpers for debugging
    def to_text() @pkey.to_text; end
    def public?() @pkey.public?; end   ## todo/check: keep - needed? - why? why not?
  end # class PublicKey




  class PrivateKey
    def self.convert( *args, **kwargs )
      if args.size==1 && args[0].is_a?( PrivateKey )
        args[0]   ## pass through as is (alread a private key)
      else
        new( args[0], group: kwargs[:group] )
      end
    end


    def self.generate( group: nil ) new( group: group ); end

    def initialize( input=nil, group: nil )
      ec_group = GROUP[ group || 'secp256k1' ]
      @pkey = OpenSSL::PKey::EC.new( ec_group )

      if input.nil?     ## auto-generate new key
        @pkey.generate_key
      else
        num = if input.is_a?( String )  ## assume hex string
                input.to_i( 16 )
              else                      ## assume integer
                input
              end
        @pkey.private_key = OpenSSL::BN.new( num )
        ## auto-calculate public key too
        @pkey.public_key = @pkey.group.generator.mul( @pkey.private_key )
      end
    end

    def to_i()  @pkey.private_key.to_i;           end
    ## todo/check/fix: make it always a 32 byte (64 hex chars) string
    ##                    even with leading zeros !!! - why? why not?
    def to_s()  @pkey.private_key.to_i.to_s(16);  end

    def group() @pkey.group; end


    def public_key
      ## cache returned public key - why? why not?
      @pub ||= PublicKey.new( @pkey.public_key )
      @pub
    end


    def sign( message )
      signature_der = @pkey.dsa_sign_asn1( message )
      Signature.decode_der( signature_der )
    end

    ## helpers for debugging
    def to_text()  @pkey.to_text; end
    def private?() @pkey.private?; end    ## todo/check: keep - needed? - why? why not?
 end # class PrivateKey





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
