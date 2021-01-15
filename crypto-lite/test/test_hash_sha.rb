###
#  to run use
#     ruby -I ./lib -I ./test test/test_hash_sha.rb


require 'helper'


class TestHash < MiniTest::Test

  SHA256_EMPTY         = 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
  SHA256_ABC           = 'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad'
  SHA256_A             = 'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb'
  SHA256_B             = '3e23e8160039594a33894f6564e1b1348bbd7a0088d42c4acb73eeaed59c009d'
  SHA256_C             = '2e7d2c03a9507ae265ecf5b5356885a53393a2029d241394997265a1a25aefc6'
  SHA256_HELLO_CRYPTOS = '33eedea60b0662c66c289ceba71863a864cf84b00e10002ca1069bf58f9362d5'


def test_empty
   assert_equal SHA256_EMPTY, sha256( '' )
   assert_equal SHA256_EMPTY, sha256( '', :openssl )
end

def test_abc
  ['abc',
   'abc'.b,
   "\x61\x62\x63",
   0x616263
  ].each do |input|
    assert_equal SHA256_ABC, sha256( input )
    assert_equal SHA256_ABC, sha256( input, :openssl )
  end

  ['616263',
   '0x616263',
   '0X616263'
  ].each do |input|
    assert_equal SHA256_ABC, sha256hex( input )
  end
## pp sha256hex( 'hello' )  -- fails - uses non-hex chars

   # a =  dec (97), hex (61), bin (01100001)

  [ 'a',
    "\x61",
    0b01100001,
    0x61
  ].each do |input|
    assert_equal SHA256_A, sha256( input )
    assert_equal SHA256_A, sha256( input, :openssl )
  end

  ['61',
   '0x61',
   '0X61'
  ].each do |input|
    assert_equal SHA256_A, sha256hex( input )
  end

  [ 'b',
    0b01100010
  ].each do |input|
    assert_equal SHA256_B, sha256( input )
  end

  [ 'c',
    0b01100011
  ].each do |input|
    assert_equal SHA256_C, sha256( input )
  end
end


def test_misc
   assert_equal SHA256_HELLO_CRYPTOS, sha256( 'Hello, Cryptos!' )
end

end # class TestHash
