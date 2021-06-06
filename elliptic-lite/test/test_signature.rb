###
#  to run use
#     ruby -I ./lib -I ./test test/test_signature.rb


require 'helper'

class TestSignature < MiniTest::Test

  def test_verify
    puts "test_verify:"
    pubkey = ECC::PublicKey.new(
               0x887387e452b8eacc4acfde10d9aaf7f6d9a0f975aabb10d006e4da568744d06c,
               0x61de6d95231cd89026e286df3b6ae4a894a3378e393e93a0f45b666329a0ae34 )
    pp pubkey

    z = 0xec208baa0fc1c19f708a9ca96fdeff3ac3f230bb4a7ba4aede4942ad003c0f60
    sig = ECC::Signature.new(
            0xac8d1c87e51d0d441be8b3dd5b05c8795b48875dffe00b7ffcfac23010d3a395,
            0x68342ceff8935ededd102dd876ffd6ba72d6a427a3edb13d26eb0781cb423c4)

    assert pubkey.verify?( z, sig )


    z = 0x7c076ff316692a3d7eb3c3bb0f8b1488cf72e1afcd929e29307032997a838a3d
    sig = ECC::Signature.new(
            0xeff69ef2b1bd93a66ed5219add4fb51e11a840f404876325a1e8ffe0529a2c,
            0xc7207fee197d27c618aea621406f6bf5ef6fca38681d82b2f06fddbdce6feab6)

    assert pubkey.verify?( z, sig )
  end

  def test_sign
    puts "test_sign:"
    e = 12345
    key = ECC::PrivateKey.new( e )

    pp z_hex = Digest::SHA256.hexdigest( 'Programming Elliptic Curve Cryptography!' )
    pp z = z_hex.to_i( 16 )

    sig = key.sign( z )
    pp sig


    pp pubkey = key.pubkey

    assert pubkey.verify?( z, sig )

    # -or-
    pubkey = ECC::PublicKey.new(
                   0xf01d6b9018ab421dd410404cb869072065522bf85734008f105cf385a023a80f,
                   0x0eba29d0f0c5408ed681984dc525982abefccd9f7ff01dd26da4999cf3f6a295 )

    sig = ECC::Signature.new(
            35839919642726191515862186078164267963984698217861116280002507416364797996230,
            34481949470477153440646085306694123309931748956488082604284303792820502002529 )

    assert pubkey.verify?( z, sig )
  end
end  # class TestSignature

