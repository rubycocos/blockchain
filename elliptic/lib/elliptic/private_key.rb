module EC

class PrivateKey
  def self.convert( *args, **kwargs )
    if args.size==1 && args[0].is_a?( PrivateKey )
      args[0]   ## pass through as is (already a private key)
    else
      new( args[0], group: kwargs[:group] )
    end
  end


  def self.from_pem( str ) new( str ); end
  def self.from_der( str ) new( str ); end

  ## todo/check: only use (allow) base64 for
  ##   der (binary)-encoded? why? why not?
  def self.from_base64( str ) new( Base64.decode64(str)); end

  class << self
    alias_method :decode_pem,    :from_pem
    alias_method :decode_der,    :from_der
    alias_method :decode_base64, :from_base64
  end


  def self.generate( group: nil ) new( group: group ); end


  def initialize( input=nil, group: nil )
    if input.nil?     ## auto-generate new key
        ec_group = GROUP[ group || 'secp256k1' ]
        @pkey = OpenSSL::PKey::EC.new( ec_group )
        @pkey.generate_key  # note: will generate private/public key pair
    elsif input.is_a?( Integer )
        ec_group = GROUP[ group || 'secp256k1' ]
        @pkey = OpenSSL::PKey::EC.new( ec_group )
        @pkey.private_key = OpenSSL::BN.new( input )
        ## auto-calculate public key too
        @pkey.public_key = @pkey.group.generator.mul( @pkey.private_key )
    else  ## assume string with possible der/pem/etc. encoding
        ## todo/check: add hex-string auto-detect too - why? why not?
        @pkey = OpenSSL::PKey::EC.new( input )
        ## todo/check: make sure public key gets restored too with pem/der-encoding??
    end
  end


  def to_i()  @pkey.private_key.to_i;           end
  ## todo/check/fix: make it always a 32 byte (64 hex chars) string
  ##                    even with leading zeros !!! - why? why not?
  def to_s()  @pkey.private_key.to_i.to_s(16);  end


  def to_pem()     @pkey.to_pem; end
  def to_der()     @pkey.to_der; end
  def to_base64()  Base64.encode64( to_der ); end



  def public_key
    ## cache returned public key - why? why not?
    @pub ||= PublicKey.new( @pkey.public_key )
    @pub
  end


  def sign( message )
    signature_der = @pkey.dsa_sign_asn1( message )
    Signature.decode_der( signature_der )
  end


  ################
  ## more helpers for debugging / internals
  def group()    @pkey.group; end
  def to_text()  @pkey.to_text; end
  def private?() @pkey.private?; end    ## todo/check: keep - needed? - why? why not?
  def public?()  @pkey.public?;  end    ## todo/check: keep - needed? - why? why not?
end # class PrivateKey

end  ## module EC