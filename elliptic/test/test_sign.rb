###
#  to run use
#     ruby -I ./lib -I ./test test/test_sign.rb


require 'helper'


class TestSign < MiniTest::Test


def test_keys
  private_key = EC::PrivateKey.new( 1234 )
  assert_equal 1234,        private_key.to_i
  assert_equal "secp256k1", private_key.group.curve_name

  public_key = private_key.public_key
  assert_equal 102884003323827292915668239759940053105992008087520207150474896054185180420338,
               public_key.point.x

  assert_equal 49384988101491619794462775601349526588349137780292274540231125201115197157452,
              public_key.point.y

  assert_equal "e37648435c60dcd181b3d41d50857ba5b5abebe279429aa76558f6653f1658f2",
               public_key.point.x.to_s(16)
  assert_equal "6d2ee9a82d4158f164ae653e9c6fa7f982ed8c94347fc05c2d068ff1d38b304c",
               public_key.point.y.to_s(16)

  assert_equal "02e37648435c60dcd181b3d41d50857ba5b5abebe279429aa76558f6653f1658f2",
               public_key.point.to_s( :compressed )

  assert_equal "04e37648435c60dcd181b3d41d50857ba5b5abebe279429aa76558f6653f1658f26d2ee9a82d4158f164ae653e9c6fa7f982ed8c94347fc05c2d068ff1d38b304c",
               public_key.point.to_s
end

def test_sign
  private_key = EC::PrivateKey.new( 1234 )

  message  = Digest::SHA256.digest( "hello" )

  ## note: sign uses a secure random generated temp key
  ##           every signature is different!!!
  signature = EC.sign( message, private_key )
  pp signature.to_der

  signature = EC.sign( message, private_key )
  pp signature.to_der

  signature = private_key.sign( message )
  pp signature.to_der

  signature = private_key.sign( message )
  pp signature.to_der


  ### verify
  public_key = private_key.public_key

  assert EC.verify?( message, signature, public_key )
  assert EC.valid_signature?( message, signature, public_key  )

  assert public_key.verify?( message, signature )
  assert public_key.valid_signature?( message, signature )

  ## public key from point (x,y)
  point = EC::Point.new(
     102884003323827292915668239759940053105992008087520207150474896054185180420338,
     49384988101491619794462775601349526588349137780292274540231125201115197157452)
  assert EC.verify?( message, signature, point )

  ## signature from r,s values
  signature = EC::Signature.new(
     17435452009115387225781053203681496505351828576563920844344513414624978140095,
     57357162317582879484266879619863223941116872722080991745355058707843528515381)
  assert EC.verify?( message, signature, point )



  ## tamper with message
  message  = Digest::SHA256.digest( "hellox" )
  assert_equal false,  EC.verify?( message, signature, public_key )
  assert_equal false,  public_key.verify?( message, signature )
end



end # class TestSign
