#  Recursive-Length Prefix (RLP) Serialization Lite


rlp-lite - light-weight ("lite") machinery to serialize / deserialze using the recursive-length prefix (rlp) scheme



* home  :: [github.com/rubycocos/blockchain](https://github.com/rubycocos/blockchain)
* bugs  :: [github.com/rubycocos/blockchain/issues](https://github.com/rubycocos/blockchain/issues)
* gem   :: [rubygems.org/gems/rlp-lite](https://rubygems.org/gems/rlp-lite)
* rdoc  :: [rubydoc.info/gems/rlp-lite](http://rubydoc.info/gems/rlp-lite)




## Usage


``` ruby
require 'rlp-lite'

######
## encode

list =  ['ruby', 'rlp', 255]

encoded = Rlp.encode( list )
#=> "\xCB\x84ruby\x83rlp\x81\xFF".b

#######
## decode

decoded = Rlp.decode( "\xCB\x84ruby\x83rlp\x81\xFF".b )
#=> ["ruby", "rlp", "\xFF".b]
```



Note:  All integers get returned (decoded) as big-endian integers in binary buffers (that is, string with binary "ASCII-8BIT" encoding)
e.g. `"\xFF".b` and not `255`.



More examples from the official ethereum rlp tests,
see [test/data/rlptest.json](test/data/rlptest.json).


``` ruby
######
# lists of lists
obj = [ [ [], [] ], [] ]
encoded = Rlp.encode( obj )
#=> "\xC4\xC2\xC0\xC0\xC0".b

decoded =  Rlp.decode( "\xC4\xC2\xC0\xC0\xC0".b )
#=> [[[], []], []]

# or using a hex string (not a binary buffer)
decoded =  Rlp.decode( "0xc4c2c0c0c0" )
#=> [[[], []], []]


#####
# dict(onary)
obj = [["key1", "val1"],
       ["key2", "val2"],
       ["key3", "val3"],
       ["key4", "val4"]]
encoded = Rlp.encode( obj )
#=> "\xEC\xCA\x84key1\x84val1\xCA\x84key2\x84val2\xCA\x84key3\x84val3\xCA\x84key4\x84val4".b

decoded = Rlp.decode( "\xEC\xCA\x84key1\x84val1\xCA\x84key2\x84val2\xCA\x84key3\x84val3\xCA\x84key4\x84val4".b )
#=> [["key1", "val1"], ["key2", "val2"], ["key3", "val3"], ["key4", "val4"]]

# or using a hex string (not a binary buffer)
decoded = Rlp.decode( "0xecca846b6579318476616c31ca846b6579328476616c32ca846b6579338476616c33ca846b6579348476616c34" )
#=> [["key1", "val1"], ["key2", "val2"], ["key3", "val3"], ["key4", "val4"]]
```



## More About the Recursive-Length Prefix (RLP) Serialization

via [Recursive-Length Prefix (RLP) Serialization](https://ethereum.org/en/developers/docs/data-structures-and-encoding/rlp/)


The RLP encoding function takes in an item. An item is defined as follows：

- a string (i.e. byte array) is an item
- a list of items is an item

For example, all of the following are items:

- an empty string;
- the string containing the word "cat";
- a list containing any number of strings;
- and a more complex data structures like `["cat", ["puppy", "cow"], "horse", [[]], "pig", [""], "sheep"]`.

Note that in the context of the rest of this page, 'string' means "a certain number of bytes of binary data"; no special encodings are used, and no knowledge about the content of the strings is implied.

RLP encoding is defined as follows:

- For a single byte whose value is in the `[0x00, 0x7f]` (decimal `[0, 127]`) range, that byte is its own RLP encoding.
- Otherwise, if a string is 0-55 bytes long, the RLP encoding consists of a single byte with value **0x80** (dec. 128) plus the length of the string followed by the string. The range of the first byte is thus `[0x80, 0xb7]` (dec. `[128, 183]`).
- If a string is more than 55 bytes long, the RLP encoding consists of a single byte with value **0xb7** (dec. 183) plus the length in bytes of the length of the string in binary form, followed by the length of the string, followed by the string. For example, a 1024 byte long string would be encoded as `\xb9\x04\x00` (dec. `185, 4, 0`) followed by the string. Here, `0xb9` (183 + 2 = 185) as the first byte, followed by the 2 bytes `0x0400` (dec. 1024) that denote the length of the actual string. The range of the first byte is thus `[0xb8, 0xbf]` (dec. `[184, 191]`).
- If the total payload of a list (i.e. the combined length of all its items being RLP encoded) is 0-55 bytes long, the RLP encoding consists of a single byte with value **0xc0** plus the length of the list followed by the concatenation of the RLP encodings of the items. The range of the first byte is thus `[0xc0, 0xf7]` (dec. `[192, 247]`).
- If the total payload of a list is more than 55 bytes long, the RLP encoding consists of a single byte with value **0xf7** plus the length in bytes of the length of the payload in binary form, followed by the length of the payload, followed by the concatenation of the RLP encodings of the items. The range of the first byte is thus `[0xf8, 0xff]` (dec. `[248, 255]`).

In code, this is:

```ruby
PRIMITIVE_PREFIX_OFFSET = 0x80    # The RLP primitive type offset (dec. 128).
LIST_PREFIX_OFFSET      = 0xc0    # The RLP array type offset (dec. 192).

def rlp_encode( input )
    if input.instance_of?( String )
        if input.length == 1 && input.ord < PRIMITIVE_PREFIX_OFFSET
           input
        else
           encode_length( input.length, PRIMITIVE_PREFIX_OFFSET ) + input
        end
    elsif input.instance_of?( Array )
        output = ''
        input.each do |item|
           output += rlp_encode( item )
        end
        encode_length( output.length, LIST_PREFIX_OFFSET ) + output
    else
         raise ArgumentError, "type error"
    end
end

def encode_length( l, offset )
    if l < 56
         (l + offset).chr
    elsif l < 256**8    ## 256**8 = 18446744073709551616
         bl = to_binary( l )
         (bl.length + offset + 55).chr + bl
    else
         raise ArgumentError, "input too long"
    end
end

def to_binary(x)
   x == 0 ? '' : to_binary( x / 256 ) + (x % 256).chr
end
```


**Examples**

- the string "dog" = [ 0x83, 'd', 'o', 'g' ]
- the list [ "cat", "dog" ] = `[ 0xc8, 0x83, 'c', 'a', 't', 0x83, 'd', 'o', 'g' ]`
- the empty string ('null') = `[ 0x80 ]`
- the empty list = `[ 0xc0 ]`
- the integer 0 = `[ 0x80 ]`
- the encoded integer 0 ('\\x00') = `[ 0x00 ]`
- the encoded integer 15 ('\\x0f') = `[ 0x0f ]`
- the encoded integer 1024 ('\\x04\\x00') = `[ 0x82, 0x04, 0x00 ]`
- the [set theoretical representation](http://en.wikipedia.org/wiki/Set-theoretic_definition_of_natural_numbers) of three, `[ [], [[]], [ [], [[]] ] ] = [ 0xc7, 0xc0, 0xc1, 0xc0, 0xc3, 0xc0, 0xc1, 0xc0 ]`
- the string "Lorem ipsum dolor sit amet, consectetur adipisicing elit" = `[ 0xb8, 0x38, 'L', 'o', 'r', 'e', 'm', ' ', ... , 'e', 'l', 'i', 't' ]`


**RLP decoding**

According to the rules and process of RLP encoding, the input of RLP decode is regarded as an array of binary data. The RLP decoding process is as follows:

1.  according to the first byte (i.e. prefix) of input data and decoding the data type, the length of the actual data and offset;

2.  according to the type and offset of data, decode the data correspondingly;

3.  continue to decode the rest of the input;

Among them, the rules of decoding data types and offset is as follows:

1.  the data is a string if the range of the first byte (i.e. prefix) is [0x00, 0x7f], and the string is the first byte itself exactly;

2.  the data is a string if the range of the first byte is [0x80, 0xb7], and the string whose length is equal to the first byte minus 0x80 follows the first byte;

3.  the data is a string if the range of the first byte is [0xb8, 0xbf], and the length of the string whose length in bytes is equal to the first byte minus 0xb7 follows the first byte, and the string follows the length of the string;

4.  the data is a list if the range of the first byte is [0xc0, 0xf7], and the concatenation of the RLP encodings of all items of the list which the total payload is equal to the first byte minus 0xc0 follows the first byte;

5.  the data is a list if the range of the first byte is [0xf8, 0xff], and the total payload of the list whose length is equal to the first byte minus 0xf7 follows the first byte, and the concatenation of the RLP encodings of all items of the list follows the total payload of the list;

In code, this is:

```ruby
def rlp_decode( input, output=[] )
  return output[0]    if input.length == 0

  offset, dataLen, type = decode_length( input )

  if type == String
      output << input[ offset, dataLen ]
  elsif type == Array
      list = []
      rlp_decode( input[ offset, dataLen], list )
      output << list
  else
      raise ArgumentError, "type error"
  end

  rlp_decode(  input[ (offset + dataLen)..-1], output )
end


def decode_length( input )
  length = input.length

  raise ArgumentError, "input is null"   if length == 0

  prefix = input[0].ord
  if prefix <= 0x7f
      [0, 1, String]
  elsif prefix <= 0xb7 && length > prefix - 0x80
      strLen = prefix - 0x80
      [1, strLen, String]
  elsif prefix <= 0xbf && length > prefix - 0xb7 && length > prefix - 0xb7 + to_integer( input[1, prefix - 0xb7] )
      lenOfStrLen = prefix - 0xb7
      strLen = to_integer( input[1, lenOfStrLen] )
      [1 + lenOfStrLen, strLen, String]
  elsif prefix <= 0xf7 && length > prefix - 0xc0
      listLen = prefix - 0xc0
      [1, listLen, Array]
  elsif prefix <= 0xff && length > prefix - 0xf7 && length > prefix - 0xf7 + to_integer( input[1, prefix - 0xf7])
      lenOfListLen = prefix - 0xf7
      listLen = to_integer( input[1, lenOfListLen] )
      [1 + lenOfListLen, listLen, Array]
  else
      raise ArgumentError, "input don't conform RLP encoding form"
  end
end


def to_integer( b )
  length = b.length
  if length == 0
      raise ArgumentError, "input is null"
  elsif length == 1
      b[0].ord
  else
      b[-1].ord + to_integer( b[0, length-1] ) * 256
  end
end
```



## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?


Post them on the [D.I.Y. Punk (Pixel) Art reddit](https://old.reddit.com/r/DIYPunkArt). Thanks.

