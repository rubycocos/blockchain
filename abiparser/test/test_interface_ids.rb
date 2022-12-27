###
#  to run use
#     ruby -I ./lib -I ./test test/test_interface_ids.rb


require 'helper'


class TestInterfaceIds < MiniTest::Test


 def test_erc165
   assert_equal   '01ffc9a7',  IERC165.interface_id
   assert_equal   '01ffc9a7', sig( 'supportsInterface(bytes4)' ).hexdigest
 end


 def test_erc20

    assert_equal '36372b07', IERC20.interface_id

    assert_equal '36372b07', (sig('totalSupply()') ^
                              sig('balanceOf(address)') ^
                              sig('allowance(address,address)') ^
                              sig('transfer(address,uint256)') ^
                              sig('approve(address,uint256)') ^
                              sig('transferFrom(address,address,uint256)')).hexdigest
 end


 def test_erc721
 end

end   ## class TestInterfaceIds
