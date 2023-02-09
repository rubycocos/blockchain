#  Application Binary Inteface (ABI) Documentation Generator For Ethereum & Co.

abidoc - application binary interface (abi) documentation generator for Ethereum & Co. (blockchain) contracts


* home  :: [github.com/rubycocos/blockchain](https://github.com/rubycocos/blockchain)
* bugs  :: [github.com/rubycocos/blockchain/issues](https://github.com/rubycocos/blockchain/issues)
* gem   :: [rubygems.org/gems/abidoc](https://rubygems.org/gems/abidoc)
* rdoc  :: [rubydoc.info/gems/abidoc](http://rubydoc.info/gems/abidoc)



## Usage


Let's try to generate the contract abi docs
for punks v1 (anno 2017):

``` ruby
require 'abidoc'

punks_v1    = '0x6ba6f2207e343923ba692e5cae646fb0f566db8d'

abi = ABI.read( "./abis/#{punks_v1}.json" )
buf = abi.generate_doc( title: 'Contract ABI for Punks V1' )
write_text( "./o/punks_v1.md", buf )
```

resulting in:


---

# Contract ABI for Punks V1


**Constructor**

- constructor()

**1 Payable Function(s)**

- function buyPunk(uint256 punkIndex) _payable_

**7 Transact Functions(s)**

- function reservePunksForOwner(uint256 maxForThisRun)
- function withdraw()
- function transferPunk(address to, uint256 punkIndex)
- function offerPunkForSaleToAddress(uint256 punkIndex, uint256 minSalePriceInWei, address toAddress)
- function offerPunkForSale(uint256 punkIndex, uint256 minSalePriceInWei)
- function getPunk(uint256 punkIndex)
- function punkNoLongerForSale(uint256 punkIndex)

**14 Query Functions(s)**

- function name() ⇒ (string _) _readonly_
- function punksOfferedForSale(uint256 _) ⇒ (bool isForSale, uint256 punkIndex, address seller, uint256 minValue, address onlySellTo) _readonly_
- function totalSupply() ⇒ (uint256 _) _readonly_
- function decimals() ⇒ (uint8 _) _readonly_
- function imageHash() ⇒ (string _) _readonly_
- function nextPunkIndexToAssign() ⇒ (uint256 _) _readonly_
- function punkIndexToAddress(uint256 _) ⇒ (address _) _readonly_
- function standard() ⇒ (string _) _readonly_
- function balanceOf(address _) ⇒ (uint256 _) _readonly_
- function symbol() ⇒ (string _) _readonly_
- function numberOfPunksToReserve() ⇒ (uint256 _) _readonly_
- function numberOfPunksReserved() ⇒ (uint256 _) _readonly_
- function punksRemainingToAssign() ⇒ (uint256 _) _readonly_
- function pendingWithdrawals(address _) ⇒ (uint256 _) _readonly_

---


Let's try to generate the contract abi docs
for punk blocks (anno 2022):

``` ruby
punk_blocks = '0x58e90596c2065befd3060767736c829c18f3474c'

abi = ABI.read( "./address/#{punk_blocks}.json" )

buf =  abi.generate_doc( title: 'Contract ABI for Punk Blocks' )
write_text( "./punk_blocks.md", buf )
```

resulting in:

---

# Contract ABI for Punk Blocks


**Constructor**

- constructor()

**1 Transact Functions(s)**

- function registerBlock(bytes _dataMale, bytes _dataFemale, uint8 _layer, string _name)

**8 Query Functions(s)**

- function blocks(bytes32 _) ⇒ (uint8 layer, bytes dataMale, bytes dataFemale) _readonly_
- function getBlocks(uint256 _fromID, uint256 _count) ⇒ (tuple[] _, uint256 _) _readonly_
- function index(uint256 _) ⇒ (bytes32 _) _readonly_
- function nextId() ⇒ (uint256 _) _readonly_
- function svgFromIDs(uint256[] _ids) ⇒ (string _) _readonly_
- function svgFromKeys(bytes32[] _attributeKeys) ⇒ (string _) _readonly_
- function svgFromNames(string[] _attributeNames) ⇒ (string _) _readonly_
- function svgFromPunkID(uint256 _tokenID) ⇒ (string _) _readonly_

---

and so on.




## Bonus - Awesome Contracts

See the [**Awesome (Ethereum) Contracts  / Blockchain Services @ Open Blockchains**](https://github.com/openblockchains/awesome-contracts) repo.
that is a cache of (ethereum) contract ABIs (application binary interfaces)
and  open source code (if verified / available)
with auto-generated docs via abidoc & friends.





## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?


Post them on the [D.I.Y. Punk (Pixel) Art reddit](https://old.reddit.com/r/DIYPunkArt). Thanks.


