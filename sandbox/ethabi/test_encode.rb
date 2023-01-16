require 'minitest/autorun'

require 'bytes'


## extend String
class String
  alias_method :hexdigest, :bin_to_hex   ## note: bin_to_hex added via Bytes!!!
end





BYTE_ZERO = "\x00".b

def encode_uint256( num )
  ## int to  big endian encoded binary string
  hex = num.to_s(16)
  hex = "0#{hex}"   if hex.size.odd?
  bin = [hex].pack("H*")

  ## zero left pad up to length (e.g. 32 bytes)
  l = 32 ## (byte) length = 32 bytes
  if bin.size >= l
     bin
  else   ## left zero pad up-to to byte length
    BYTE_ZERO * (l - bin.size) + bin
  end
end

def encode_bool( value )
  encode_uint256( value ? 1 : 0 );
end


class TestEncode < MiniTest::Test

###  abi encode uint256   (256bit is 32 bytes) try
  UINT256 = [
    [0,   '0000000000000000000000000000000000000000000000000000000000000000'],
    [1,   '0000000000000000000000000000000000000000000000000000000000000001'],
    [16,  '0000000000000000000000000000000000000000000000000000000000000010'],
    [99,  '0000000000000000000000000000000000000000000000000000000000000063'],
    [256, '0000000000000000000000000000000000000000000000000000000000000100'],
    [999, '00000000000000000000000000000000000000000000000000000000000003e7'],
  ]
  def test_uint256
    UINT256.each do |num, hex|
       assert_equal hex, encode_uint256( num ).hexdigest
    end
  end

   BOOL = [
    [false, '0000000000000000000000000000000000000000000000000000000000000000'],
    [true,  '0000000000000000000000000000000000000000000000000000000000000001'],
   ]

   def test_bool
    BOOL.each do |bool, hex|
       assert_equal hex, encode_bool( bool ).hexdigest
    end
  end
end  # class TestEncode

