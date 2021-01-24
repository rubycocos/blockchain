###
#  to run use
#     ruby -I ./lib -I ./test test/test_decode.rb


require 'helper'


class TestDecode < MiniTest::Test


def test_import_export

   private_key = EC::PrivateKey.generate
   puts "PrivateKey#to_i:"
   puts private_key.to_i
   puts "PrivateKey#to_s:"
   puts private_key.to_s
   puts "PrivateKey#to_pem:"
   puts private_key.to_pem
   puts "PrivateKey#to_der (binary / asn1):"
   puts private_key.to_der
   pp private_key.to_der
   puts "PrivateKey#to_base64:"
   puts private_key.to_base64

   public_key  = private_key.public_key
   assert_equal false, public_key.private?  ## make sure (derived) public key has no private key included/attached

   puts "PublicKey#point:"
   pp public_key.point
   puts "PublicKey#point.to_s:"
   puts public_key.point.to_s
   puts "PublicKey#to_pem:"
   puts public_key.to_pem
   puts "PublicKey#to_der (binary / asn1):"
   puts public_key.to_der
   pp public_key.to_der
   puts "PublicKey#to_base64:"
   puts public_key.to_base64



   [
     EC::PrivateKey.new( private_key.to_i ),

     EC::PrivateKey.new( private_key.to_pem ),
     EC::PrivateKey.decode_pem( private_key.to_pem ),

     EC::PrivateKey.new( private_key.to_der ),
     EC::PrivateKey.decode_der( private_key.to_der ),

     EC::PrivateKey.decode_base64( private_key.to_base64 ),
   ].each do |private_key_decoded|
      assert_equal private_key_decoded.to_i, private_key.to_i
      assert private_key_decoded.private?
      assert private_key_decoded.public?

      assert_equal false, private_key_decoded.public_key.private?
      assert_equal private_key_decoded.public_key.point.to_s, public_key.point.to_s
      assert_equal private_key_decoded.public_key.point.x, public_key.point.x
      assert_equal private_key_decoded.public_key.point.y, public_key.point.y
   end


   [
      EC::PublicKey.new( public_key.point ),

      EC::PublicKey.new( public_key.to_pem ),
      EC::PublicKey.decode_pem( public_key.to_pem ),

      EC::PublicKey.new( public_key.to_der ),
      EC::PublicKey.decode_der( public_key.to_der ),

      EC::PublicKey.decode_base64( public_key.to_base64 ),
   ].each do |public_key_decoded|
      assert_equal public_key_decoded.point.to_s, public_key.point.to_s
      assert_equal public_key_decoded.point.x, public_key.point.x
      assert_equal public_key_decoded.point.y, public_key.point.y
      assert public_key_decoded.public?
      assert_equal false, public_key_decoded.private?
   end
end

end # class TestDecode
