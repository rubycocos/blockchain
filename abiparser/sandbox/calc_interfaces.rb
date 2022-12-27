###
#  to run use
#     ruby -I ./lib sandbox/calc_interfaces.rb

require 'abiparser'



#  see https://eips.ethereum.org/EIPS/eip-165
#
# interface ERC165 {
#    /// @notice Query if a contract implements an interface
#    /// @param interfaceID The interface identifier, as specified in ERC-165
#    /// @dev Interface identification is specified in ERC-165. This function
#    ///  uses less than 30,000 gas.
#    /// @return `true` if the contract implements `interfaceID` and
#    ///  `interfaceID` is not 0xffffffff, `false` otherwise
#    function supportsInterface(bytes4 interfaceID) external view returns (bool);
# }
# The interface identifier for this interface is 0x01ffc9a7.
# You can calculate this by running bytes4(keccak256('supportsInterface(bytes4)'));
#    or using the Selector contract above.

pp keccak256( 'supportsInterface(bytes4)' ).hexdigest
#=> "01ffc9a7a5cef8baa21ed3c5c0d7e23accb804b619e9333b597f47a0d84076e2"
pp keccak256( 'supportsInterface(bytes4)' ).hexdigest[0,8]
#=> "01ffc9a7"


#
#     bytes4(keccak256('balanceOf(address)')) == 0x70a08231
#     bytes4(keccak256('ownerOf(uint256)')) == 0x6352211e
#     bytes4(keccak256('approve(address,uint256)')) == 0x095ea7b3
#     bytes4(keccak256('getApproved(uint256)')) == 0x081812fc
#     bytes4(keccak256('setApprovalForAll(address,bool)')) == 0xa22cb465
#     bytes4(keccak256('isApprovedForAll(address,address)')) == 0xe985e9c5
#     bytes4(keccak256('transferFrom(address,address,uint256)')) == 0x23b872dd
#     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) == 0x42842e0e
#     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)')) == 0xb88d4fde
#
#     => 0x70a08231 ^ 0x6352211e ^ 0x095ea7b3 ^ 0x081812fc ^
#        0xa22cb465 ^ 0xe985e9c ^ 0x23b872dd ^ 0x42842e0e ^ 0xb88d4fde == 0x80ac58cd
#
# bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;

pp sig( 'balanceOf(address)' ).hexdigest
#=> "70a08231"    == 0x70a08231
pp sig( 'ownerOf(uint256)' ).hexdigest
#=> "6352211e"    == 0x6352211e

pp (
    sig('balanceOf(address)') ^
    sig('ownerOf(uint256)') ^
    sig('approve(address,uint256)') ^
    sig('getApproved(uint256)') ^
    sig('setApprovalForAll(address,bool)') ^
    sig('isApprovedForAll(address,address)') ^
    sig('transferFrom(address,address,uint256)') ^
    sig('safeTransferFrom(address,address,uint256)') ^
    sig('safeTransferFrom(address,address,uint256,bytes)') ).hexdigest


#
#     bytes4(keccak256('name()')) == 0x06fdde03
#     bytes4(keccak256('symbol()')) == 0x95d89b41
#     bytes4(keccak256('tokenURI(uint256)')) == 0xc87b56dd
#
#     => 0x06fdde03 ^ 0x95d89b41 ^ 0xc87b56dd == 0x5b5e139f
#
# bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;

pp sig( 'name()' ).hexdigest
#=>  0x06fdde03
pp sig( 'symbol()' ).hexdigest
#=> 0x95d89b41
pp sig( 'tokenURI(uint256)' ).hexdigest
#=> 0xc87b56dd

pp (sig( 'name()' ) ^ sig( 'symbol()' ) ^ sig( 'tokenURI(uint256)' )).hexdigest



#     bytes4(keccak256('totalSupply()')) == 0x18160ddd
#     bytes4(keccak256('tokenOfOwnerByIndex(address,uint256)')) == 0x2f745c59
#     bytes4(keccak256('tokenByIndex(uint256)')) == 0x4f6ccce7
#
#     => 0x18160ddd ^ 0x2f745c59 ^ 0x4f6ccce7 == 0x780e9d63
#
#    bytes4 private constant _INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;

pp (sig( 'totalSupply()' ) ^
    sig( 'tokenOfOwnerByIndex(address,uint256)' ) ^
    sig( 'tokenByIndex(uint256)' )).hexdigest


## IERC20  0x36372b07
##

pp (sig( 'totalSupply()' ) ^
    sig( 'balanceOf(address)' ) ^
    sig( 'allowance(address,address)' ) ^
    sig( 'transfer(address,uint256)' ) ^
    sig( 'approve(address,uint256)' ) ^
    sig( 'transferFrom(address,address,uint256)' )).hexdigest


pp (sig('name()')).hexdigest
pp (sig('symbol()')).hexdigest
pp (sig('decimals()')).hexdigest



IERC165                = Interface.new( 'ERC165', '0x01ffc9a7'.hex_to_bin )
IERC20                 = Interface.new( 'ERC20',  '0x36372b07'.hex_to_bin )
IERC721                = Interface.new( 'ERC721', '0x80ac58cd'.hex_to_bin )
IERC721_METADATA       = Interface.new( 'ERC721_METADATA', '0x5b5e139f'.hex_to_bin )
IERC721_ENUMERABLE     = Interface.new( 'ERC721_ENUMERABLE', '0x780e9d63'.hex_to_bin )

interfaces = [
  IERC165,       ## supportsInterface
  IERC20,        ##  token interface
  IERC721,       ##  (non-fungible) token interface
  IERC721_METADATA,   ##  (non-fungible) token interface / metadata
  IERC721_ENUMERABLE, ##  (non-fungible) token interface / enumerable
]


puts "bye"

__END__

## IERC20.interfaceId

supportedInterfaces[0x36372b07] = true; // ERC20
    supportedInterfaces[0x06fdde03] = true; // ERC20 name
    supportedInterfaces[0x95d89b41] = true; // ERC20 symbol
    supportedInterfaces[0x313ce567] = true; // ERC20 decimals

_registerInterface(type(IERC20).interfaceId);
_registerInterface(ERC20.name.selector);
_registerInterface(ERC20.symbol.selector);
_registerInterface(ERC20.decimals.selector);
and test them like this

const erc165Interface = await mytokenInstance.supportsInterface('0x01ffc9a7'); // true
const tokenInterface = await mytokenInstance.supportsInterface('0x36372b07'); // true
const tokenNameInterface = await mytokenInstance.supportsInterface('0x06fdde03'); // true
const tokenSymbolInterface = await mytokenInstance.supportsInterface('0x95d89b41'); // true
const tokenDecimalsInterface = await mytokenInstance.supportsInterface('0x313ce567'); // true
const tokenNoneExistingInterface = await mytokenInstance.supportsInterface('0x19be5360'); // false


