# More RLP (Recursive-Length Prefix) Notes

move to rlp-lite - why? why not?


via
<https://medium.com/coinmonks/data-structure-in-ethereum-episode-1-recursive-length-prefix-rlp-encoding-decoding-d1016832f919>

Encoding Rules

THRESHOLD_LONG      = 110
## if a string is 0-55 bytes long (110 hexchars = 55x2)


PREFIX_SELF_CONTAINED = 0x7f   # 127    ##   - 0b1111111
OFFSET_SHORT_ITEM     = 0x80   # 128      ##   - 0b10000000
OFFSET_LONG_ITEM      = 0xb7   # 183      ##
OFFSET_SHORT_LIST     = 0xc0   # 192      ##
OFFSET_LONG_LIST      = 0xf7   # 247       ##



1. If input is a single byte in the [0x00, 0x7f] range, so itself is RLP encoding.

2. If input is non-value (uint(0), []byte{}, string(“”), empty pointer …), RLP encoding is 0x80. Notice that 0x00 value byte is not non-value.

3. If input is a special byte in [0x80, 0xff] range, RLP encoding will concatenates 0x81 with the byte, [0x81, the_byte].

4. If input is a string with 2–55 bytes long, RLP encoding consists of a single byte with value 0x80 plus the length of the string in bytes and then array of hex value of string. It’s easy to see that the first byte is in [0x82, 0xb7] range.
For example: “hello world” = [0x8b, 0x68, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x77, 0x6f, 0x72, 0x6c, 0x64] , because “hello world” has 11 bytes in dec or 0x0b in hex, so the first byte of RLP encoding is 0x80 + 0x0b = 0x8b , after that we concatenate the bytes of “hello word”.

5. If input is a string with more than 55 bytes long, RLP encoding consists of 3 parts from the left to the right. The first part is a single byte with value 0xb7 plus the length in bytes of the second part. The second part is hex value of the length of the string. The last one is the string in bytes. The range of the first byte is [0xb8, 0xbf].
For example: a string with 1024 “a” characters, so the encoding is “aaa…” = [0xb9, 0x04, 0x00, 0x61, 0x61, …]. As we can see, from the forth element of array 0x61 to the end is the string in bytes and this is the third part. The second part is 0x04, 0x00 and it is the length of the string 0x0400 = 1024. The first part is 0xb9 = 0xb7 + 0x02 with 0x02 being the length of the second part.

### more rules for lists!!!

6. If input is an empty list/array, RLP encoding is a single byte 0xc0.

7. If input is a list/array with total payload in 0–55 bytes long, RLP encoding consists of a single byte with value 0xc0 plus the length of the list and then the concatenation of RLP encodings of the items in list. The range of the first byte is [0xc1, 0xf7].
For example: [“hello”, “world”] = [0xcc, 0x85, 0x68, 0x65, 0x6c, 0x6c, 0x6f, 0x85, 0x77, 0x6f, 0x72, 0x6c, 0x64]. In this RLP encoding, [0x85, 0x68, 0x65, 0x6c, 0x6c, 0x6f] is RLP encoding of “hello”, [0x85, 0x77, 0x6f, 0x72, 0x6c, 0x64] is RLP encoding of “world” and 0xcc = 0xc0 + 0x0c with 0x0c = 0x06 + 0x06 being the length of total payload.

8. If input is a list/array with total payload more than 55 bytes long, RLP encoding includes 3 parts. The first one is a single byte with value 0xf7 plus the length in bytes of the second part. The second part is the length of total payload. The last part is the concatenation of RLP encodings of the items in list. The range of the first byte is [0xf8, 0xff] .

9. One more thing, it is not mentioned in wiki Ethereum but in Golang source code. With boolean type, true = 0x01 and false = 0x80 .


