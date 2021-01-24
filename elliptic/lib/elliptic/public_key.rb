module EC


class PublicKey
  def self.convert( *args, **kwargs )
    if args.size==1 && args[0].is_a?( PublicKey )
      args[0]   ## pass through as is (already a public key)
    else
      new( *args, group: kwargs[:group] )
    end
  end



  def self.decode_pem( str ) new( str ); end
  def self.decode_der( str ) new( str ); end

  ## todo/check: only use (allow) base64 for
  ##   der (binary)-encoded? why? why not?
  def self.decode_base64( str ) new( Base64.decode64(str)); end

  class << self
    alias_method :from_pem,      :decode_pem
    alias_method :from_der,      :decode_der
    alias_method :from_base64,   :decode_base64
  end


  def initialize( *args, group: nil )
    if args.size == 2   ## assume (x,y) raw integer points
        @pt = Point.new( *args, group: group )
        point = @pt.to_ec_point  ## convert point to openssl (native) class
        @pkey = OpenSSL::PKey::EC.new( point.group )
        @pkey.public_key = point
    elsif args[0].is_a?( Point ) ||
          args[0].is_a?( OpenSSL::PKey::EC::Point )
       ##  "restore"  public key (only) from point for verify
       ## - OpenSSL::PKey::EC::Point   ## assume public key only (restore pkey object for verify?)
       ## - Point
        point = if args[0].is_a?( Point )
                  @pt = args[0]
                  @pt.to_ec_point
                else
                  args[0]   ## assume it is already OpenSSL::PKey::EC::Point
                end

        ## note: (auto)get group from point
        @pkey = OpenSSL::PKey::EC.new( point.group )
        @pkey.public_key = point
    else  ## assume string in pem/der/base64
      @pkey = OpenSSL::PKey::EC.new( args[0] )
    end
  end



  def point
    ## cache returned point - why? why not?
    @pt ||= Point.new( @pkey.public_key )
    @pt
  end


  def to_pem()  @pkey.to_pem; end
  def to_der()  @pkey.to_der; end
  def to_base64()  Base64.encode64( to_der ); end


  def verify?( message, signature )
    signature_der = signature.to_der
    @pkey.dsa_verify_asn1( message, signature_der )
  end
  alias_method :valid_signature?, :verify?


  ###
  ## more helpers for debugging / internals
  def group() @pkey.group; end
  def to_text()  @pkey.to_text; end
  def private?() @pkey.private?; end    ## todo/check: keep - needed? - why? why not?
  def public?()  @pkey.public?; end     ## todo/check: keep - needed? - why? why not?
end # class PublicKey


end  ## module EC