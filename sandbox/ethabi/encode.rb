####
#  test rlp (recursive-length prefix) encoding/decoding "by hand"
#
#

##
##
#  digest-lite gem  fix banner!!
##   prints => Digestlite


require 'bytes'
require 'digest-lite'


## extend String
class String
  alias_method :hexdigest, :bin_to_hex   ## note: bin_to_hex added via Bytes!!!
end


def keccak256( bin )
  Digest::KeccakLite.new( 256 ).digest( bin )
end

def sig( bin )
  keccak256( bin )[0,4]
end


sig = 'tokenURI(uint256)'
pp sighash = sig( sig )
#=> "\xC8{V\xDD"
pp sighash.hexdigest
#=> "c87b56dd"

## check via
##  https://www.4byte.directory/signatures/?bytes4_signature=0xc87b56dd


###  abi encode uint256   (256bit is 32 bytes) try
##     0  => 0000000000000000000000000000000000000000000000000000000000000000
##     1  => 0000000000000000000000000000000000000000000000000000000000000001
##    16  => 0000000000000000000000000000000000000000000000000000000000000010
##    99  => 0000000000000000000000000000000000000000000000000000000000000063
##    256 => 0000000000000000000000000000000000000000000000000000000000000100
##    999 => 00000000000000000000000000000000000000000000000000000000000003e7

###  bool
##    false => 0000000000000000000000000000000000000000000000000000000000000000
##    true =>  0000000000000000000000000000000000000000000000000000000000000001




BYTE_ZERO = "\x00".b

def encode_uint256( num )
  l = 32 ## (byte) length = 32 bytes

  ## int to  big endian encoded binary string
  hex = num.to_s(16)
  hex = "0#{hex}"   if hex.size.odd?
  bin = [hex].pack("H*")

  ## zero left pad up to length (e.g. 32 bytes)
  if bin.size >= l
     bin
  else   ## left zero pad up-to to byte length
    BYTE_ZERO * (l - bin.size) + bin
  end
end


pp encode_uint256( 0 ).hexdigest
pp encode_uint256( 1 ).hexdigest
pp encode_uint256( 16 ).hexdigest

pp encode_uint256( 99 ).hexdigest
pp encode_uint256( 256 ).hexdigest
pp encode_uint256( 999 ).hexdigest



## rlp constants
##  from https://ethereum-php.org/dev/d6/d33/class_ethereum_1_1_r_l_p_1_1_rlp.html
##   https://ethereum-php.org/dev/index.html
##   http://ethereum-php.org

#   //if a string is 0-55 bytes long, the RLP encoding consists
#     // of a single byte with value 0x80 plus the length of the string
#     // followed by the string. The range of the first byte is thus [0x80, 0xb7].
#     const THRESHOLD_LONG = 110; // As we count hex chars this value is 110
#     const PREF_SELF_CONTAINED = 127; // 0x7F
#     const OFFSET_SHORT_ITEM = 128; // 0x80
#     const OFFSET_LONG_ITEM = 183; // 0xb7;
#     const OFFSET_SHORT_LIST = 192; // 0xc0;
#     const OFFSET_LONG_LIST = 247; // 0xf7;
#  see https://ethereum-php.org/dev/d1/db7/_rlp_8php_source.html


THRESHOLD_LONG = 110         ## 0x6e
PREF_SELF_CONTAINED = 127    ## 0x7f  - 0b1111111
OFFSET_SHORT_ITEM = 128      ## 0x80  - 0b10000000
OFFSET_LONG_ITEM  = 183      ## 0xb7
OFFSET_SHORT_LIST = 192      ## 0xc0
OFFSET_LONG_LIST = 247       ## 0xf7



## string





puts "bye"
