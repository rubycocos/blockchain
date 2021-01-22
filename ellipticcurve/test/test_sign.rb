###
#  to run use
#     ruby -I ./lib -I ./test test/test_sign.rb


require 'helper'


class TestSign < MiniTest::Test


def test_keys
  algo = EC::Algo.new( 1234 )
  assert_equal 1234,        algo.private_key
  assert_equal "secp256k1", algo.group.curve_name

  public_key = algo.public_key
  assert_equal 102884003323827292915668239759940053105992008087520207150474896054185180420338,
               public_key.x

  assert_equal 49384988101491619794462775601349526588349137780292274540231125201115197157452,
              public_key.y

  assert_equal "e37648435c60dcd181b3d41d50857ba5b5abebe279429aa76558f6653f1658f2",
               public_key.x.to_s(16)
  assert_equal "6d2ee9a82d4158f164ae653e9c6fa7f982ed8c94347fc05c2d068ff1d38b304c",
               public_key.y.to_s(16)

  assert_equal "02e37648435c60dcd181b3d41d50857ba5b5abebe279429aa76558f6653f1658f2",
               public_key.to_s( :compressed )

  assert_equal "04e37648435c60dcd181b3d41d50857ba5b5abebe279429aa76558f6653f1658f26d2ee9a82d4158f164ae653e9c6fa7f982ed8c94347fc05c2d068ff1d38b304c",
               public_key.to_s
end

def test_sign
  algo = EC::Algo.new( 1234 )
  priv_key = algo.private_key

  message  = Digest::SHA256.digest( "hello" )

  ## note: sign uses a secure random generated temp key
  ##           every signature is different!!!
  signature = EC.sign( message, priv_key )
  pp signature.to_der

  signature = EC.sign( message, priv_key )
  pp signature.to_der

  signature = EC.sign( message, priv_key )
  pp signature.to_der

  pp algo.sign( message )


  ### verify
  public_key = algo.public_key

  assert EC.verify?( message, public_key, signature )
  assert EC.valid_signature?( message, public_key, signature )

  assert algo.verify?( message, signature )
  assert algo.valid_signature?( message, signature )

  ## public key from point (x,y)
  point = EC::Point.new(
     102884003323827292915668239759940053105992008087520207150474896054185180420338,
     49384988101491619794462775601349526588349137780292274540231125201115197157452)
  assert EC.verify?( message, point, signature )

  ## signature from r,s values
  signature = EC::Signature.new(
     17435452009115387225781053203681496505351828576563920844344513414624978140095,
     57357162317582879484266879619863223941116872722080991745355058707843528515381)
  assert EC.verify?( message, point, signature )



  ## tamper with message
  message  = Digest::SHA256.digest( "hellox" )
  assert_equal false,  EC.verify?( message, public_key, signature )
  assert_equal false,  algo.verify?( message, signature )
end



end # class TestSign
