###
#  to run use
#     ruby -I ./lib -I ./test test/test_base58_flickr.rb


require 'helper'


class TestBase58Flickr < MiniTest::Test

NUM_TESTS = [
  [3471391110,  "6hKMCS"],
  [3470152229,  "6hDrmR"],
  [3470988633,  "6hHHZB"],
  [3470993664,  "6hHKum"],
  [3471485480,  "6hLgFW"],
  [3469844075,  "6hBRKR"],
  [3470820062,  "6hGRTd"],
  [3469966999,  "6hCuie"],
]


def test_num
  NUM_TESTS.each do |item|
    assert_equal item[1],  Base58::Flickr.encode_num( item[0] )
    assert_equal item[0],  Base58::Flickr.decode_num( item[1] )

    Base58.format = :flickr
    assert_equal item[1],  Base58.encode_num( item[0] )
    assert_equal item[0],  Base58.decode_num( item[1] )
  end
end


end  # class TestBase58Flickr
