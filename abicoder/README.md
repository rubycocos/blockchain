#  Application Binary Inteface (ABI) Coder For Ethereum & Co.

abicoder - "lite" application binary interface (abi) encoding / decoding machinery / helper for Ethereum & Co. (blockchain) contracts with zero-dependencies for easy (re)use


* home  :: [github.com/rubycocos/blockchain](https://github.com/rubycocos/blockchain)
* bugs  :: [github.com/rubycocos/blockchain/issues](https://github.com/rubycocos/blockchain/issues)
* gem   :: [rubygems.org/gems/abicoder](https://rubygems.org/gems/abicoder)
* rdoc  :: [rubydoc.info/gems/abicoder](http://rubydoc.info/gems/abicoder)



## Usage


###  Encode & Decode Types (Contract Function Call Data)


``` ruby
require 'abicode'

#####
#  try ABI.encode

##  Encoding simple types
types = [ 'uint256', 'string' ]
args  = [ 1234, 'Hello World' ]
ABI.encode( types, args )   # returns binary blob / string
#=> hex"00000000000000000000000000000000000000000000000000000000000004d2"+
#      "0000000000000000000000000000000000000000000000000000000000000040"+
#      "000000000000000000000000000000000000000000000000000000000000000b"+
#      "48656c6c6f20576f726c64000000000000000000000000000000000000000000"

## Encoding with arrays types
types = [ 'uint256[]', 'string' ]
args  = [ [1234, 5678] , 'Hello World' ]
ABI.encode( types, args )    # returns binary blob / string
#=> hex"0000000000000000000000000000000000000000000000000000000000000040"+
#      "00000000000000000000000000000000000000000000000000000000000000a0"+
#      "0000000000000000000000000000000000000000000000000000000000000002"+
#      "00000000000000000000000000000000000000000000000000000000000004d2"+
#      "000000000000000000000000000000000000000000000000000000000000162e"+
#      "000000000000000000000000000000000000000000000000000000000000000b"+
#      "48656c6c6f20576f726c64000000000000000000000000000000000000000000"

## Encoding complex structs (also known as tuples)
types = [ 'uint256', '(uint256,string)']
args = [1234, [5678, 'Hello World']]
ABI.encode( types, args )    # returns binary blob / string
#=> hex'00000000000000000000000000000000000000000000000000000000000004d2'+
#      '0000000000000000000000000000000000000000000000000000000000000040'+
#      '000000000000000000000000000000000000000000000000000000000000162e'+
#      '0000000000000000000000000000000000000000000000000000000000000040'+
#      '000000000000000000000000000000000000000000000000000000000000000b'+
#      '48656c6c6f20576f726c64000000000000000000000000000000000000000000'


#####
#  try ABI.decode

##  Decoding simple types
types = [ 'uint256', 'string' ]
data = hex'00000000000000000000000000000000000000000000000000000000000004d2'+
          '0000000000000000000000000000000000000000000000000000000000000040'+
          '000000000000000000000000000000000000000000000000000000000000000b'+
          '48656c6c6f20576f726c64000000000000000000000000000000000000000000'
ABI.decode( types, data)   # returns args
#=>  [1234, "Hello World"]


##  Decoding with arrays types
types = [ 'uint256[]', 'string' ]
data = hex'0000000000000000000000000000000000000000000000000000000000000040'+
          '00000000000000000000000000000000000000000000000000000000000000a0'+
          '0000000000000000000000000000000000000000000000000000000000000002'+
          '00000000000000000000000000000000000000000000000000000000000004d2'+
          '000000000000000000000000000000000000000000000000000000000000162e'+
          '000000000000000000000000000000000000000000000000000000000000000b'+
          '48656c6c6f20576f726c64000000000000000000000000000000000000000000'
ABI.decode( types, data )   # returns args
#=>  [[1234, 5678], "Hello World"]


## Decoding complex structs (also known as tuples)
types = [ 'uint256', '(uint256,string)']
data = hex'00000000000000000000000000000000000000000000000000000000000004d2'+
          '0000000000000000000000000000000000000000000000000000000000000040'+
          '000000000000000000000000000000000000000000000000000000000000162e'+
          '0000000000000000000000000000000000000000000000000000000000000040'+
          '000000000000000000000000000000000000000000000000000000000000000b'+
          '48656c6c6f20576f726c64000000000000000000000000000000000000000000'
ABI.decode( types, data )   # returns args
#=> [1234, [5678, "Hello World"]]
```

and so on.





## Reference

For the full (and latest) official application
binary inteface (abi) specification
see the [**Contract ABI Specification**](https://docs.soliditylang.org/en/develop/abi-spec.html).


### Types

The following elementary types are supported:

- `uint<M>`: unsigned integer type of `M` bits, `0 < M <= 256`, `M % 8 == 0`. e.g. `uint32`, `uint8`, `uint256`.
- `int<M>`: two's complement signed integer type of `M` bits, `0 < M <= 256`, `M % 8 == 0`.
- `address`: equivalent to `uint160`, except for the assumed interpretation and language typing.
  For computing the function selector, `address` is used.
- `bool`: equivalent to `uint8` restricted to the values 0 and 1. For computing the function selector, `bool` is used.
- `bytes<M>`: binary type of `M` bytes, `0 < M <= 32`.


The following (fixed-size) array types are supported:

- `<type>[M]`: a fixed-length array of `M` elements, `M >= 0`, of the given type.

<!--
Note: While this ABI specification can express fixed-length arrays with zero elements,
they're not supported by the compiler.
-->

The following non-fixed-size types are supported:

- `bytes`: dynamic sized byte sequence.
- `string`: dynamic sized unicode string assumed to be UTF-8 encoded.
- `<type>[]`: a variable-length array of elements of the given type.

Types can be combined to a tuple by enclosing them inside parentheses, separated by commas:

- `(T1,T2,...,Tn)`: tuple consisting of the types `T1`, ..., `Tn`, `n >= 0`

It is possible to form tuples of tuples, arrays of tuples and so on.

<!--
It is also possible to form zero-tuples (where `n == 0`).
-->




## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?


Post them on the [D.I.Y. Punk (Pixel) Art reddit](https://old.reddit.com/r/DIYPunkArt). Thanks.


