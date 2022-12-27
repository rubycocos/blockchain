###
#  to run use
#     ruby -I ./lib -I ./test test/test_support.rb


require 'helper'


class TestSupport < MiniTest::Test

  def test_punks_v1
    punks_v1    = '0x6ba6f2207e343923ba692e5cae646fb0f566db8d'
    abi = ABI.read( "../test/address/#{punks_v1}.json" )

    assert  abi.support?( 'name()' )
    assert  abi.support?( '0x06fdde03' )
    assert  abi.support?( '0x06FDDE03' )
    assert  abi.support?( '06fdde03' )
    assert  abi.support?( '06FDDE03' )
    assert  abi.support?( IERC20_NAME )

    assert  abi.support?( 'symbol()' )
    assert  abi.support?( IERC20_SYMBOL )

    ## note:  allowance(address,address) missing in contract for ERC20
    assert_equal false,  abi.support?( IERC20 )
    assert_equal false,  abi.support?( IERC165 )
  end


  def test_punk_blocks
    punk_blocks = '0x58e90596c2065befd3060767736c829c18f3474c'
    abi = ABI.read( "../test/address/#{punk_blocks}.json" )

    assert  abi.support?( 'registerBlock(bytes,bytes,uint8,string)' )
    assert  abi.support?( 'getBlocks(uint256,uint256)' )

    assert_equal false,  abi.support?( IERC165 )
    assert_equal false,  abi.support?( IERC20 )
    assert_equal false,  abi.support?( IERC721 )
  end


end   ## class TestSupport