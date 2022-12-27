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

   assert_equal '06fdde03', IERC20_NAME.interface_id
   assert_equal '06fdde03', sig('name()').hexdigest
   assert_equal '95d89b41', IERC20_SYMBOL.interface_id
   assert_equal '95d89b41', sig('symbol()').hexdigest
   assert_equal '313ce567', IERC20_DECIMALS.interface_id
   assert_equal '313ce567', sig('decimals()').hexdigest
 end


 def test_erc721
   assert_equal '80ac58cd', IERC721.interface_id
   assert_equal '80ac58cd', (sig('balanceOf(address)') ^
                             sig('ownerOf(uint256)') ^
                             sig('approve(address,uint256)') ^
                             sig('getApproved(uint256)') ^
                             sig('setApprovalForAll(address,bool)') ^
                             sig('isApprovedForAll(address,address)') ^
                             sig('transferFrom(address,address,uint256)') ^
                             sig('safeTransferFrom(address,address,uint256)') ^
                             sig('safeTransferFrom(address,address,uint256,bytes)')).hexdigest

  assert_equal '5b5e139f',  IERC721_METADATA.interface_id
  assert_equal '5b5e139f',  (sig('name()') ^
                             sig('symbol()') ^
                             sig('tokenURI(uint256)')).hexdigest

   assert_equal '780e9d63', IERC721_ENUMERABLE.interface_id
   assert_equal '780e9d63', (sig('tokenOfOwnerByIndex(address,uint256)') ^
                             sig('totalSupply()') ^
                             sig('tokenByIndex(uint256)')).hexdigest
 end
end   ## class TestInterfaceIds
