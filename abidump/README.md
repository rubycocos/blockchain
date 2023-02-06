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
    inputs (0):
       []

==> event Assign:
      anonymous: false
    inputs (2):
      - type: address
        indexed: true
        name: to
      - type: uint256
        indexed: false
        name: punkIndex

==> event Transfer:
      anonymous: false
    inputs (3):
      - type: address
        indexed: true
        name: from
      - type: address
        indexed: true
        name: to
      - type: uint256
        indexed: false
        name: value

==> event PunkTransfer:
      anonymous: false
    inputs (3):
      - type: address
        indexed: true
        name: from
      - type: address
        indexed: true
        name: to
      - type: uint256
        indexed: false
        name: punkIndex

...

==> function name:
      constant: true
      payable: false
    inputs (0):
       []
    outputs (1):
      - type: string
        name: _

==> function reservePunksForOwner:
      constant: false
      payable: false
    inputs (1):
      - type: uint256
        name: maxForThisRun
    outputs (0):
       []

==> function punksOfferedForSale:
      constant: true
      payable: false
    inputs (1):
      - type: uint256
        name: _
    outputs (5):
      - type: bool
        name: isForSale
      - type: uint256
        name: punkIndex
      - type: address
        name: seller
      - type: uint256
        name: minValue
      - type: address
        name: onlySellTo

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
    inputs (0):
       []

==> event NewBlock:
      anonymous: false
    inputs (3):
      - type: address
        indexed: false
        name: _
      - type: uint256
        indexed: false
        name: _
      - type: string
        indexed: false
        name: _

==> function blocks:
      stateMutability: view
    inputs (1):
      - type: bytes32
        name: _
    outputs (3):
      - type: uint8 (enum PunkBlocks.Layer)
        name: layer
      - type: bytes
        name: dataMale
      - type: bytes
        name: dataFemale

==> function getBlocks:
      stateMutability: view
    inputs (2):
      - type: uint256
        name: _fromID
      - type: uint256
        name: _count
    outputs (2):
      - type: tuple[] (struct PunkBlocks.Block[])
        name: _
        components:
        - type: uint8 (enum PunkBlocks.Layer)
          name: layer
        - type: bytes
          name: dataMale
        - type: bytes
          name: dataFemale
      - type: uint256
        name: _

==> function index:
      stateMutability: view
    inputs (1):
      - type: uint256
        name: _
    outputs (1):
      - type: bytes32
        name: _

==> function nextId:
      stateMutability: view
    inputs (0):
       []
    outputs (1):
      - type: uint256
        name: _

==> function registerBlock:
      stateMutability: nonpayable
    inputs (4):
      - type: bytes
        name: _dataMale
      - type: bytes
        name: _dataFemale
      - type: uint8
        name: _layer
      - type: string
        name: _name
    outputs (0):
       []

==> function svgFromIDs:
      stateMutability: view
    inputs (1):
      - type: uint256[]
        name: _ids
    outputs (1):
      - type: string
        name: _

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

