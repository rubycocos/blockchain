
module ECC

class S256Field < FiniteField::Element
  P = 2**256 - 2**32 - 977
  def self.prime() P; end
end

class S256Point < Point
  def self.curve() @curve ||= Curve.new( a: 0, b: 7, f: S256Field ); end

  def inspect   ## change to fixed 64 char hexstring for x/y
    if infinity?
      "#{self.class.name}(:infinity)"
    else
      "#{self.class.name}(#{'0x%064x' % @x},#{'0x%064x' % @y})"
    end
  end
end # class S256Point


# use Secp256k1 - why? why not?
#   or use GROUP_SECP256K1 or SECP256K1_GROUP  (different from "plain" CURVE_SECP256K1) - why? why not?
SECP256K1 = Group.new(
              g: S256Point.new( 0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798,
                                0x483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8 ),
              n: 0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141
)
end # module ECC


