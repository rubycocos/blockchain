###
#  to run use
#     ruby -I ./lib -I ./test test/test_base58_bitcoin.rb


require 'helper'


class TestBase58Bitcoin < MiniTest::Test

NUM_TESTS = [
  [100,        "2j"],
  [12345,      "4fr"],
  [6639914,    "b2pH"],
  [123456789,  "BukQL"],

  [3471391110, "6Hknds"],
  [3470152229, "6HeSMr"],
  [3470988633, "6Hiizc"],
  [3470993664, "6HikVM"],
  [3471485480, "6HmGgw"],
  [3469844075, "6Hcrkr"],
]

HEX_TESTS = [
  ["", ""],
  ["00000000000000000000", "1111111111"],
  ["00000000000000000000123456789abcdef0", "111111111143c9JGph3DZ"],
  ["13", "L"],
  ["2e", "o"],
  ["61", "2g"],
  ["626262", "a3gV"],
  ["636363", "aPEr"],
  ["73696d706c792061206c6f6e6720737472696e67", "2cFupjhnEsSn59qHXstmK2ffpLv2"],
  ["00eb15231dfceb60925886b67d065299925915aeb172c06647", "1NS17iag9jJgTHD1VXjvLCEnZuQ3rJDE9L"],
  ["516b6fcd0f", "ABnLTmg"],
  ["bf4f89001e670274dd", "3SEo3LWLoPntC"],
  ["572e4794", "3EFU7m"],
  ["ecac89cad93923c02321", "EJDM8drfXA6uyA"],
  ["10c8511e", "Rt5zm"],
]

BIN_TESTS = [
   ["\xCE\xE99\x86".b, "6Hknds"],
   ["\xCE\xD6R%".b,    "6HeSMr"],
   ["\xCE\xE3\x15Y".b, "6Hiizc"],
   ["\xCE\xE3)\x00".b, "6HikVM"],
   ["\xCE\xEA\xAA(".b, "6HmGgw"],
   ["\xCE\xD1\x9Ek".b, "6Hcrkr"],
   ["\x01\xAD<l'\xAF!\x96N\x93u\x93\xE2\xAF\x92p\x96=\x89n\xD7\x953\x17\x12\x8E\xBD\xA2\x04\x84~Z".b, "7Ycsh3K7oGpLTcQpNx1h7Z19fVbZ4TXqEYePfdFwDZT"],
]



def test_num
  NUM_TESTS.each do |item|
    assert_equal item[1],  Base58::Bitcoin.encode_num( item[0] )
    assert_equal item[0],  Base58::Bitcoin.decode_num( item[1] )

    Base58.format = :bitcoin
    assert_equal item[1],  Base58.encode_num( item[0] )
    assert_equal item[0],  Base58.decode_num( item[1] )
  end
end

def test_hex
  HEX_TESTS.each do |item|
    assert_equal item[1],  Base58::Bitcoin.encode_hex( item[0] )
    assert_equal item[0],  Base58::Bitcoin.decode_hex( item[1] )

    Base58.format = :bitcoin
    assert_equal item[1],  Base58.encode_hex( item[0] )
    assert_equal item[0],  Base58.decode_hex( item[1] )
  end
end

def test_bin
  BIN_TESTS.each do |item|
    assert_equal item[1],  Base58::Bitcoin.encode_bin( item[0] )
    assert_equal item[0],  Base58::Bitcoin.decode_bin( item[1] )

    Base58.format = :bitcoin
    assert_equal item[1],  Base58.encode_bin( item[0] )
    assert_equal item[0],  Base58.decode_bin( item[1] )
  end
end



end  # class TestBase58Bitcoin
