# abidump


abidump gem - command-line tool to dump / pretty print or (re)format application binary interfaces (abi) for Ethereum & Co.


* home  :: [github.com/rubycocos/blockchain](https://github.com/rubycocos/blockchain)
* bugs  :: [github.com/rubycocos/blockchain/issues](https://github.com/rubycocos/blockchain/issues)
* gem   :: [rubygems.org/gems/abidump](https://rubygems.org/gems/abidump)
* rdoc  :: [rubydoc.info/gems/abidump](http://rubydoc.info/gems/abidump)



## New to the Solidity (Contract) Programming Language?

See [**Awesome Solidity @ Open Blockchains »**](https://github.com/openblockchains/awesome-solidity)




## Usage


Let's try a dry run:

```
$ abidump --help
```

resulting in:

```
==> welcome to the abidump tool

Usage: abidump [options]
    -j, --json                       use json format (default: false)
    -y, --yaml                       use yaml format (default: false)
    -h, --help                       Prints this help
```


Let's pretty print (dump) the application binary interface (abi)
for punks v1 (anno 2017):

```
$ abidump ./address/0x6ba6f2207e343923ba692e5cae646fb0f566db8d/abi.json
```

resulting in:


```
==> summary:
    29 abi item(s):
      1 constructor
      6 events
         Assign, Transfer, PunkTransfer, PunkOffered, PunkBought, PunkNoLongerForSale
      22 functions
         name, reservePunksForOwner, punksOfferedForSale, totalSupply, decimals, withdraw, imageHash, nextPunkIndexToAssign, punkIndexToAddress, standard, balanceOf, buyPunk, transferPunk, symbol, numberOfPunksToReserve, numberOfPunksReserved, offerPunkForSaleToAddress, punksRemainingToAssign, offerPunkForSale, getPunk, pendingWithdrawals, punkNoLongerForSale

==> constructor:
      payable: true
    inputs (0)

==> event Assign:
      anonymous: false
    inputs (2):
      address indexed to
      uint256 punkIndex

==> event Transfer:
      anonymous: false
    inputs (3):
      address indexed from
      address indexed to
      uint256 value

==> event PunkTransfer:
      anonymous: false
    inputs (3):
      address indexed from
      address indexed to
      uint256 punkIndex

...


==> function name:
      constant: true
      payable: false
    inputs (0)
    outputs (1):
      string _

==> function reservePunksForOwner:
      constant: false
      payable: false
    inputs (1):
      uint256 maxForThisRun
    outputs (0)

==> function punksOfferedForSale:
      constant: true
      payable: false
    inputs (1):
      uint256 _
    outputs (5):
      bool isForSale
      uint256 punkIndex
      address seller
      uint256 minValue
      address onlySellTo

...
```


Let's try to dump (pretty print) the
application binary interface (abi)
for punk blocks (anno 2022):

```
$ abidump ./address/0x58e90596c2065befd3060767736c829c18f3474c/abi.json
```

resulting in:

```
==> summary:
    11 abi item(s):
      1 constructor
      1 event
         NewBlock
      9 functions
         blocks, getBlocks, index, nextId, registerBlock, svgFromIDs, svgFromKeys, svgFromNames, svgFromPunkID

==> constructor:
      stateMutability: nonpayable
    inputs (0)

==> event NewBlock:
      anonymous: false
    inputs (3):
      address _
      uint256 _
      string _

==> function blocks:
      stateMutability: view
    inputs (1):
      bytes32 _
    outputs (3):
      uint8 layer - enum PunkBlocks.Layer
      bytes dataMale
      bytes dataFemale

==> function getBlocks:
      stateMutability: view
    inputs (2):
      uint256 _fromID
      uint256 _count
    outputs (2):
      tuple[] _ - struct PunkBlocks.Block[]
        uint8 layer - enum PunkBlocks.Layer
        bytes dataMale
        bytes dataFemale
      uint256 _

==> function index:
      stateMutability: view
    inputs (1):
      uint256 _
    outputs (1):
      bytes32 _

==> function nextId:
      stateMutability: view
    inputs (0)
    outputs (1):
      uint256 _

==> function registerBlock:
      stateMutability: nonpayable
    inputs (4):
      bytes _dataMale
      bytes _dataFemale
      uint8 _layer
      string _name
    outputs (0)

==> function svgFromIDs:
      stateMutability: view
    inputs (1):
      uint256[] _ids
    outputs (1):
      string _

...
```


and so on.


Bonus - Using the `-j / --json` switch / flag
or `-y / --yaml`   you can (re)export or (re)format
the application binary interface (abi)
to pretty printed json or yaml. Example.


```
$ abidump --json ./address/0x58e90596c2065befd3060767736c829c18f3474c/abi.json
$ abidump --yaml ./address/0x58e90596c2065befd3060767736c829c18f3474c/abi.json
```



## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?


Post them on the [D.I.Y. Punk (Pixel) Art reddit](https://old.reddit.com/r/DIYPunkArt). Thanks.

