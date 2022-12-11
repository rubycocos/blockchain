###
#  to run use
#     ruby -I ./lib -I ./test test/test_hash_sha.rb


require 'helper'


class TestHashSha < MiniTest::Test

  SHA256_ABC           = 'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad'
  SHA256_A             = 'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb'
  SHA256_B             = '3e23e8160039594a33894f6564e1b1348bbd7a0088d42c4acb73eeaed59c009d'
  SHA256_C             = '2e7d2c03a9507ae265ecf5b5356885a53393a2029d241394997265a1a25aefc6'


  BIN_TESTS = [
    ['',                'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'],
    ['Hello, Cryptos!', '33eedea60b0662c66c289ceba71863a864cf84b00e10002ca1069bf58f9362d5'],

    ['Blockchain 1',    '223aae3830e87aff41db07714983671429a74fb7064646e27ab62adbdc892cd1'],
    ['Blockchain 2',    '8f4b5a896e78f680de2c141d25533e8c9207c9ee0d9b09c22a5a01d7992e7d1b'],
    ['Blockchain 3',    'f9f5e7d64f3a93f071900a73d34b2b722867adcb09345a21a25b5cd7f8b41254'],
    ['Blockchain 4',    '69580cfb9a134395106ac27de53595cc41fb9940dcc298082c87144932a983a9'],
    ['Blockchain 12',   'f94455d34e7b32dc7dac780fb94a5e958f0d7e2da4cc6500505d5daed719c227'],
    ['Blockchain 13',   '0cedb5e229c9582a35ec291ccb172b3f7c76a20c7f645e08d24ece8d5692e153'],

    ['Satoshi Nakamoto', 'a0dc65ffca799873cbea0ac274015b9526505daaaed385155425f7337704883e'],
    ['Satoshi Nakamot0', '73d607aab917435d5e79857769996c95027d4e42172698e0776e1295e285730e'],
  ]



def assert_hexdigest( exp, bin )
  assert_equal exp, bin.hexdigest
end



def test_bin
   BIN_TESTS.each do |item|
     assert_hexdigest item[1], Crypto.sha256( item[0].b )
     assert_hexdigest item[1], Crypto.sha256( item[0].b, engine: 'openssl' )
   end
end


def test_abc
  ['abc',
   'abc'.b,
   "\x61\x62\x63",
   # 0x616263
  ].each do |input|
    assert_hexdigest SHA256_ABC, Crypto.sha256( input )
    assert_hexdigest SHA256_ABC, Crypto.sha256( input, engine: 'openssl' )
  end

  ['616263',
   '0x616263',
   '0X616263'
  ].each do |input|
    assert_hexdigest SHA256_ABC, Crypto.sha256( hex: input )
  end
## pp sha256hex( 'hello' )  -- fails - uses non-hex chars

   # a =  dec (97), hex (61), bin (01100001)

  [ 'a',
    "\x61",
    # 0b01100001,
    # 0x61
  ].each do |input|
    assert_hexdigest SHA256_A, Crypto.sha256( input )
    assert_hexdigest SHA256_A, Crypto.sha256( input, engine: 'openssl' )
  end

  ['61',
   '0x61',
   '0X61'
  ].each do |input|
    assert_hexdigest SHA256_A, Crypto.sha256( hex: input )
  end

  [ 'b',
    # 0b01100010
  ].each do |input|
    assert_hexdigest SHA256_B, Crypto.sha256( input )
  end

  [ 'c',
    # 0b01100011
  ].each do |input|
    assert_hexdigest SHA256_C, Crypto.sha256( input )
  end
end

end # class TestHashSha
