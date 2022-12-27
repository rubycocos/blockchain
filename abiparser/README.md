#  Application Binary Inteface (ABI) Parser For Ethereum & Co.

abiparser - application binary interface (abi) parser machinery / helper for Ethereum & Co. (blockchain) contracts


* home  :: [github.com/rubycocos/blockchain](https://github.com/rubycocos/blockchain)
* bugs  :: [github.com/rubycocos/blockchain/issues](https://github.com/rubycocos/blockchain/issues)
* gem   :: [rubygems.org/gems/abiparser](https://rubygems.org/gems/abiparser)
* rdoc  :: [rubydoc.info/gems/abiparser](http://rubydoc.info/gems/abiparser)



## Usage


### Functions Signature Hashes / Selectors & Interface (Type) Ids


You can calculate the function selectors (or "sighash",
that is, signature hash)
by hashing the function signature
e.g. `supportsInterface(bytes4)` with the Keccak 256-Bit algorithm
and than use the first 4 bytes, that is, `0x01ffc9a7` (out of 32 bytes),
that is, `0x01ffc9a7a5cef8baa21ed3c5c0d7e23accb804b619e9333b597f47a0d84076e2`. Example:


``` ruby
require 'abiparser'

sig = 'supportsInterface(bytes4)'
pp keccak256( sig )[0,4].hexdigest
#=> "0x01ffc9a7"
```

Note: The `String#hexdigest` (also known as `String#bin_to_hex`) helper
converts a binary string (with `BINARY`/`ASCII-8BIT` encoding)
into a hex(adecimal) string.


You can calcuate interface (type) ids
by xor-ing (`^`) together the sighashes.
If the interface only has one function than
the interface (type) id equals the function sighash (by definition).


``` solidity
interface ERC165 {
    /// @notice Query if a contract implements an interface
    /// @param interfaceID The interface identifier, as specified in ERC-165
    /// @dev Interface identification is specified in ERC-165.
    /// @return `true` if the contract implements `interfaceID` and
    ///  `interfaceID` is not 0xffffffff, `false` otherwise
  function supportsInterface(bytes4 interfaceID) external view returns (bool);
}
// The interface identifier for this interface is 0x01ffc9a7.
```

If you check the sighash for `supportsInterface(bytes4)`,
that is, `0x01ffc9a7`  (see above)
than -  bingo! - the  interface id for ERC165 matches up.


Let's try to calculate the ERC20 standard (fungible) token interface
where the official id is `0x36372b07` by xor-ing (`^`) together all function sighashes:

``` ruby
pp (keccak256('totalSupply()')[0,4] ^
    keccak256('balanceOf(address)')[0,4] ^
    keccak256('allowance(address,address)')[0,4] ^
    keccak256('transfer(address,uint256)')[0,4] ^
    keccak256('approve(address,uint256)')[0,4] ^
    keccak256('transferFrom(address,address,uint256)')[0,4]).hexdigest
#=> "0x36372b07"

# or where   def sig(bin) = keccak256(bin)[0,4])

pp (sig('totalSupply()') ^
    sig('balanceOf(address)') ^
    sig('allowance(address,address)') ^
    sig('transfer(address,uint256)') ^
    sig('approve(address,uint256)') ^
    sig('transferFrom(address,address,uint256)')).hexdigest
#=> "0x36372b07"
```

Voila!
Or re(use) the builtin pre-defined interfaces. Example:

``` ruby
pp IERC165.inteface_id             #=> "0x01ffc9a7"
pp IERC20.interface_id             #=> "0x36372b07"
pp IERC721.interface_id            #=> "0x80ac58cd"
pp IERC721_METADATA.interface_id   #=> "0x5b5e139f"
pp IERC721_ENUMERABLE.interface_id #=> "0x780e9d63"
```

Yes, you can. Define your own interface. Let's have a looksie
at the built-ins. Example:

``` ruby
IERC165 = ABI::Interface.new(
  'supportsInterface(bytes4)'
)

IERC20  = ABI::Interface.new(
   'totalSupply()',
   'balanceOf(address)',
   'allowance(address,address)',
   'transfer(address,uint256)',
   'approve(address,uint256)',
   'transferFrom(address,address,uint256)'
)

IERC721 = ABI::Interface.new(
  'balanceOf(address)',
  'ownerOf(uint256)',
  'approve(address,uint256)',
  'getApproved(uint256)',
  'setApprovalForAll(address,bool)',
  'isApprovedForAll(address,address)',
  'transferFrom(address,address,uint256)',
  'safeTransferFrom(address,address,uint256)',
  'safeTransferFrom(address,address,uint256,bytes)' )

IERC721_METADATA = ABI::Interface.new(
  'name()',
  'symbol()',
  'tokenURI(uint256)' )

IERC721_ENUMERABLE = ABI::Interface.new(
  'tokenOfOwnerByIndex(address,uint256)',
  'totalSupply()',
  'tokenByIndex(uint256)' )

...
```


To be continued...





## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?


Post them on the [D.I.Y. Punk (Pixel) Art reddit](https://old.reddit.com/r/DIYPunkArt). Thanks.


