# Solidity

solidity gem - (fuzzy) parser for (crypto) contracts for ethereum & co.


* home  :: [github.com/rubycocos/blockchain](https://github.com/rubycocos/blockchain)
* bugs  :: [github.com/rubycocos/blockchain/issues](https://github.com/rubycocos/blockchain/issues)
* gem   :: [rubygems.org/gems/solidity](https://rubygems.org/gems/solidity)
* rdoc  :: [rubydoc.info/gems/solidity](http://rubydoc.info/gems/solidity)





## Usage

Get / generate outline from source in the solidity (`.sol`) contract programming language:

```ruby
[
 "0x34625ecaa75c0ea33733a05c584f4cf112c10b6b",
 "0x0cfdb3ba1694c2bb2cfacb0339ad7b1ae5932b63",
 "0x031920cc2d9f5c10b444fd44009cd64f829e7be2"
].each do |addr|

  path = "awesome-contracts/address/#{addr}/contract.sol"
  txt = read_text( path )

  parser = Solidity::Parser.new( txt )

  puts "---"
  puts "outline:"
  puts parser.outline

  ## bonus: dump the pragmas (required solidity compiler versions)
  puts
  puts "pragmas:"
  puts parser.pragmas
```

Resulting in:

```
outline:
contract NounsDescriptor is INounsDescriptor, Ownable
abstract contract Ownable is Context
library Strings
interface INounsDescriptor
interface INounsSeeder
library NFTDescriptor
library MultiPartRLEToSVG
abstract contract Context
library Base64
```


```
outline:
contract Indelible is ERC721A, ReentrancyGuard, Ownable
library DynamicBuffer
library HelperLib
library SSTORE2
library Bytecode
abstract contract Ownable is Context
abstract contract ReentrancyGuard
library Address
library Base64
abstract contract Context
library MerkleProof
contract ERC721A is IERC721A
interface IERC721A
```


```
outline:
contract CryptoZunks is Ownable, ERC721Enumerable, ERC721Burnable, ReentrancyGuard
abstract contract Ownable is Context
abstract contract ReentrancyGuard
contract ERC721 is Context, ERC165, IERC721, IERC721Metadata
abstract contract ERC721Burnable is Context, ERC721
abstract contract ERC721Enumerable is ERC721, IERC721Enumerable
library Strings
library EnumerableMap
library console
abstract contract Context
interface IERC721 is IERC165
interface IERC721Receiver
interface IERC721Metadata is IERC721
library Address
abstract contract ERC165 is IERC165
interface IERC165
interface IERC721Enumerable is IERC721
library EnumerableSet
```




## License

The `solidity` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Post them on the [D.I.Y. Punk (Pixel) Art reddit](https://old.reddit.com/r/DIYPunkArt). Thanks.

