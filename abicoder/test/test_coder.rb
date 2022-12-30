##
#  to run use
#     ruby -I ./lib -I ./test test/test_coder.rb


require 'helper'

class String
  ## add bin_to_hex helper method
  ##   note: String#hex already in use (is an alias for String#to_i(16) !!)
  def hexdigest() self.unpack('H*').first; end
end

def hex( hex )  # convert hex(adecimal) string  to binary string
 if ['0x', '0X'].include?( hex[0,2] )   ## cut-of leading 0x or 0X if present
   [hex[2..-1]].pack('H*')
 else
   [hex].pack('H*')
 end
end



class TestCoder < MiniTest::Test


def test_encode

  assert_equal "00000000000000000000000000000000000000000000000000000000000004d2"+
               "0000000000000000000000000000000000000000000000000000000000000040"+
               "000000000000000000000000000000000000000000000000000000000000000b"+
               "48656c6c6f20576f726c64000000000000000000000000000000000000000000",
    ABI.encode( [ 'uint256', 'string' ], [ 1234, 'Hello World' ]).hexdigest

  assert_equal "0000000000000000000000000000000000000000000000000000000000000040"+
               "00000000000000000000000000000000000000000000000000000000000000a0"+
               "0000000000000000000000000000000000000000000000000000000000000002"+
               "00000000000000000000000000000000000000000000000000000000000004d2"+
               "000000000000000000000000000000000000000000000000000000000000162e"+
               "000000000000000000000000000000000000000000000000000000000000000b"+
               "48656c6c6f20576f726c64000000000000000000000000000000000000000000",
  ABI.encode([ 'uint256[]', 'string' ], [ [1234, 5678] , 'Hello World' ]).hexdigest
end

def test_decode
  data = hex'00000000000000000000000000000000000000000000000000000000000004d2'+
  '0000000000000000000000000000000000000000000000000000000000000040'+
  '000000000000000000000000000000000000000000000000000000000000000b'+
  '48656c6c6f20576f726c64000000000000000000000000000000000000000000'

  assert_equal [1234, 'Hello World'],
                ABI.decode([ 'uint256', 'string' ], data)


  data = hex'0000000000000000000000000000000000000000000000000000000000000040'+
            '00000000000000000000000000000000000000000000000000000000000000a0'+
          '0000000000000000000000000000000000000000000000000000000000000002'+
          '00000000000000000000000000000000000000000000000000000000000004d2'+
          '000000000000000000000000000000000000000000000000000000000000162e'+
          '000000000000000000000000000000000000000000000000000000000000000b'+
          '48656c6c6f20576f726c64000000000000000000000000000000000000000000'
   assert_equal [[1234, 5678], 'Hello World'],
                ABI.decode([ 'uint256[]', 'string' ], data )


   data = hex'00000000000000000000000000000000000000000000000000000000000004d2'+
          '0000000000000000000000000000000000000000000000000000000000000040'+
          '000000000000000000000000000000000000000000000000000000000000162e'+
          '0000000000000000000000000000000000000000000000000000000000000040'+
          '000000000000000000000000000000000000000000000000000000000000000b'+
          '48656c6c6f20576f726c64000000000000000000000000000000000000000000'
   assert_equal [1234, [5678, 'Hello World']],
                 ABI.decode([ 'uint256', '(uint256,string)'], data )
end


def test_codec
    types = [ 'uint256', 'string' ]
    args  = [1234, "Hello World"]
    assert_equal args, ABI.decode( types, ABI.encode( types, args ))

    types = [ 'uint256[]', 'string' ]
    args =  [ [1234, 5678] , 'Hello World' ]
    assert_equal args, ABI.decode( types, ABI.encode( types, args ))
end

end  ## class TestCoder

