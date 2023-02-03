# abi2sol


abi2sol gem - command-line tool for application binary interface (abi) to solidity (contract) source code generation for Ethereum & Co.


* home  :: [github.com/rubycocos/blockchain](https://github.com/rubycocos/blockchain)
* bugs  :: [github.com/rubycocos/blockchain/issues](https://github.com/rubycocos/blockchain/issues)
* gem   :: [rubygems.org/gems/abi2sol](https://rubygems.org/gems/abi2sol)
* rdoc  :: [rubydoc.info/gems/abi2sol](http://rubydoc.info/gems/abi2sol)



## New to the Solidity (Contract) Programming Language?

See [**Awesome Solidity @ Open Blockchains »**](https://github.com/openblockchains/awesome-solidity)




## Usage


Let's try a dry run:

```
$ abi2sol --help
```

resulting in:

```
abiparser/0.1.2 on Ruby 3.1.1
==> welcome to the abi2parse tool

Usage: abi2sol [options]
        --name STRING                name of contract interface (default: nil)
    -h, --help                       Prints this help
```


Let's try to generate the contract solidity source code
for punks v1 (anno 2017):

```
$ abi2sol --name PunksV1 ./address/0x6ba6f2207e343923ba692e5cae646fb0f566db8d/abi.json
```

resulting in:


``` solidity
interface PunksV1 {
// 1 Payable Function(s)
function buyPunk(uint256 punkIndex) payable ;

// 7 Transact Functions(s)
function reservePunksForOwner(uint256 maxForThisRun);
function withdraw();
function transferPunk(address to, uint256 punkIndex);
function offerPunkForSaleToAddress(uint256 punkIndex, uint256 minSalePriceInWei, address toAddress);
function offerPunkForSale(uint256 punkIndex, uint256 minSalePriceInWei);
function getPunk(uint256 punkIndex);
function punkNoLongerForSale(uint256 punkIndex);

// 14 Query Functions(s)
function name() view  returns (string _);
function punksOfferedForSale(uint256 _) view  returns (bool isForSale, uint256 punkIndex, address seller, uint256 minValue, address onlySellTo);
function totalSupply() view  returns (uint256 _);
function decimals() view  returns (uint8 _);
function imageHash() view  returns (string _);
function nextPunkIndexToAssign() view  returns (uint256 _);
function punkIndexToAddress(uint256 _) view  returns (address _);
function standard() view  returns (string _);
function balanceOf(address _) view  returns (uint256 _);
function symbol() view  returns (string _);
function numberOfPunksToReserve() view  returns (uint256 _);
function numberOfPunksReserved() view  returns (uint256 _);
function punksRemainingToAssign() view  returns (uint256 _);
function pendingWithdrawals(address _) view  returns (uint256 _);
}
```


Let's try to generate the contract solidity source code
for punk blocks (anno 2022):

```
$ abi2sol --name PunkBlocks ./address/0x58e90596c2065befd3060767736c829c18f3474c/abi.json
```

resulting in:

``` solidity
interface PunkBlocks {
// 1 Transact Functions(s)
function registerBlock(bytes _dataMale, bytes _dataFemale, uint8 _layer, string _name);

// 8 Query Functions(s)
function blocks(bytes32 _) view  returns (uint8 layer /* enum PunkBlocks.Layer */, bytes dataMale, bytes dataFemale);
function getBlocks(uint256 _fromID, uint256 _count) view  returns ((uint8,bytes,bytes)[] _ /* struct PunkBlocks.Block[] */, uint256 _);
function index(uint256 _) view  returns (bytes32 _);
function nextId() view  returns (uint256 _);
function svgFromIDs(uint256[] _ids) view  returns (string _);
function svgFromKeys(bytes32[] _attributeKeys) view  returns (string _);
function svgFromNames(string[] _attributeNames) view  returns (string _);
function svgFromPunkID(uint256 _tokenID) view  returns (string _);
}

```


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

