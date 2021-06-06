###########
#  Elliptic Curve Digital Signature Algorithm (ECDSA)

module ECC


class Signature
  attr_reader :r, :s
  def initialize( r, s )
    @r, @s = r, s
  end
end # class Signature


class PublicKey
  attr_reader :point

  def initialize( *args, group: SECP256K1 )
    @group = group

    if args.size == 1     ## assume it's a point already -- todo/fix: check class via group - why? why not?
      @point = args[0]
    elsif args.size == 2  ## assume it's an x/y coord pair -- todo/fix: check must be Integer class/type - why? why not?
      @point = @group.point( *args )
    else
      raise ArgumentError, "expected point or x/y coords for point; got: #{args.inspect}"
    end
  end

  def verify?( z, sig )
    s_inv = sig.s.pow( @group.n-2, @group.n )
    u = z * s_inv % @group.n
    v = sig.r * s_inv % @group.n

    total = u*@group.g + v*@point
    total.x == sig.r
  end
end # class PublicKey


class PrivateKey
  def initialize( secret, group: SECP256K1 )
    @secret = secret
    @group  = group
  end

  def public_key
    @pubkey ||= PublicKey.new( @secret * @group.g, group: @group )
  end
  alias_method :pubkey, :public_key

  def sign( z )
    k = 1 + SecureRandom.random_number( @group.n - 1)
    # k = 1234567890
    r = (k*@group.g).x
    k_inv = k.pow( @group.n-2, @group.n )
    s = (z+r*@secret) * k_inv % @group.n
    s = @group.n - s   if s > @group.n/2
    Signature.new( r, s )
  end
end # class PrivateKey
end # module ECC
