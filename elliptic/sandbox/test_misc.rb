###
#  to run use
#     ruby -I ./lib sandbox/test_misc.rb

require 'elliptic'


priv = EC::PrivateKey.generate
pp priv.to_i
pp priv.to_i.digits.size
pp priv.to_s
pp priv.to_s.size


puts "---"

priv = EC::PrivateKey.new( 12345 )
pp priv.to_i           #=> 12345
pp priv.to_s           #=> "0000000000000000000000000000000000000000000000000000000000003039"
pp priv.to_s.to_i(16)  #=> 12345

##
##  todo/check/verify
##     0 is not allowed for private key (starting with 1)
##    cannot calculate point with 0 e.g.  K=G*0 ???
##
##  todo/check/verify
##   check max value is   order or order-1 ????
##    again cannot calculate point with order or is infinity/0 or such???
##   todo/fix:  assert if num is in range e.g. > 0 and < order (or <=order) ??
##                           raise ArgumentError in PrivateKey!!!!!
priv = EC::PrivateKey.new( 0 )
pp priv.to_i
pp priv.to_s
# pub =  priv.public_key
# pp pub.point


###
##  todo/check:
##    K=G*1  is K (public key) now the same as G (generator point) - check - why? why not?
priv = EC::PrivateKey.new( 1 )
pp priv.to_i
pp priv.to_s
pub =  priv.public_key
pp pub.point
### x=55066263022277343669578718895168534326250603453777594175500187360389116729240,
### y=32670510020758816978083085130507043184471273380659243275938904335757337482424

pp EC::SECP256K1.to_text     #=> "ASN1 OID: secp256k1\n"
pp EC::SECP256K1.curve_name  #=> "secp256k1"
pp EC::SECP256K1.generator
pp EC::Point.new( EC::SECP256K1.generator )
### x=55066263022277343669578718895168534326250603453777594175500187360389116729240,
### y=32670510020758816978083085130507043184471273380659243275938904335757337482424


pp EC::SECP256K1.order #=>  115792089237316195423570985008687907852837564279074904382605163141518161494337
pp EC::Secp256k1.order


### todo/check:
##  add a random/rand/random_numer  helper to group
##    e.g.
##  EC::Secp256k1.rand    #=>    - why? why not?
##    use 1+securerand( order-1 ) or such??? why? why not?




puts "bye"