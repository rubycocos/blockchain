###
#  to run use
#     ruby -I ./lib -I ./test test/test_base58_bitcoin.rb


require 'helper'


class TestBase58Bitcoin < MiniTest::Test


def test_bitcoin
  assert_equal "2j",     Base58::Bitcoin.encode( 100 )
  assert_equal "4fr",    Base58::Bitcoin.encode( 12345 )
  assert_equal "b2pH",   Base58::Bitcoin.encode( 6639914 )

  assert_equal 100,      Base58::Bitcoin.decode( "2j" )
  assert_equal 12345,    Base58::Bitcoin.decode( "4fr" )
  assert_equal 6639914,  Base58::Bitcoin.decode( "b2pH" )


  Base58.format = :bitcoin
  assert_equal "2j",     Base58.encode( 100 )
  assert_equal "4fr",    Base58.encode( 12345 )
  assert_equal "b2pH",   Base58.encode( 6639914 )

  assert_equal 100,      Base58.decode( "2j" )
  assert_equal 12345,    Base58.decode( "4fr" )
  assert_equal 6639914,  Base58.decode( "b2pH" )
end



end  # class TestBase58Bitcoin
