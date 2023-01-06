##
#  to run use
#     ruby -I ./lib -I ./test test/test_spec.rb

###
#  try the examples from the official abi spec
#    see https://docs.soliditylang.org/en/develop/abi-spec.html

require 'helper'


class TestSpec < MiniTest::Test


 def assert_bin( exp, bin )   ## note: always check for BINARY encoding too
    assert bin.encoding == Encoding::BINARY
    assert_equal exp, bin
 end



def test_baz    ## baz(uint32,bool)
  types = ['uint32', 'bool']
  args  = [69,true]

  data   = hex'0000000000000000000000000000000000000000000000000000000000000045'+
              '0000000000000000000000000000000000000000000000000000000000000001'
  assert_bin  data, ABI.encode( types, args )
  assert_equal args, ABI.decode( types, ABI.encode( types, args ))
end


def test_bar   ## bar(bytes3[2])
    types = ['bytes3[2]']
    args =  [['abc'.b,
              'def'.b]]

  data = hex'6162630000000000000000000000000000000000000000000000000000000000' +
            '6465660000000000000000000000000000000000000000000000000000000000'
  assert_bin   data, ABI.encode( types, args )
  assert_equal args, ABI.decode( types, ABI.encode( types, args ))
end


def test_sam   ## sam(bytes,bool,uint256[])
   types = ['bytes','bool','uint256[]']
   args = ['dave'.b,
            true,
            [1,2,3]]

  data = hex'0000000000000000000000000000000000000000000000000000000000000060' + # 1 (location#1)
        '0000000000000000000000000000000000000000000000000000000000000001' + # 2 (bool)
        '00000000000000000000000000000000000000000000000000000000000000a0' + # 3 (location#3)
        '0000000000000000000000000000000000000000000000000000000000000004' + # 4 (bytes length)
        '6461766500000000000000000000000000000000000000000000000000000000' + # 5 (bytes)
        '0000000000000000000000000000000000000000000000000000000000000003' +
        '0000000000000000000000000000000000000000000000000000000000000001' +
        '0000000000000000000000000000000000000000000000000000000000000002' +
        '0000000000000000000000000000000000000000000000000000000000000003'

  #  1 - the location of the data part of the first parameter (dynamic type),
  #      measured in bytes from the start of the arguments block.
  #       In this case, 0x60 (decimal 96 - 3*32).
  #  2 -  the second parameter: boolean true.
  #  3 -  the location of the data part of the third parameter (dynamic type),
  #       measured in bytes. In this case, 0xa0 (decimal 160 - 5*32).
  #  4 -  the data part of the first argument,
  #        it starts with the length of the byte array in elements, in this case, 4.
  #  5 -  the contents of the first argument:
  #        the UTF-8 (equal to ASCII in this case) encoding of "dave",
  #        padded on the right to 32 bytes.
  #  ...

  assert_bin  data, ABI.encode( types, args )
  assert_equal args, ABI.decode( types, ABI.encode( types, args ))
end

def test_f  ## f(uint256,uint32[],bytes10,bytes)
  types = ['uint256','uint32[]','bytes10','bytes']
  args  = [0x123,
           [0x456, 0x789],
           '1234567890'.b,
           'Hello, world!'.b ]

  data = hex'0000000000000000000000000000000000000000000000000000000000000123' +
        '0000000000000000000000000000000000000000000000000000000000000080' +
        '3132333435363738393000000000000000000000000000000000000000000000' +
        '00000000000000000000000000000000000000000000000000000000000000e0' +
        '0000000000000000000000000000000000000000000000000000000000000002' +
        '0000000000000000000000000000000000000000000000000000000000000456' +
        '0000000000000000000000000000000000000000000000000000000000000789' +
        '000000000000000000000000000000000000000000000000000000000000000d' +
        '48656c6c6f2c20776f726c642100000000000000000000000000000000000000'

  assert_bin  data, ABI.encode( types, args )
  assert_equal args, ABI.decode( types, ABI.encode( types, args ))
end

def test_g     ## g(uint256[][],string[])
    types = ['uint256[][]','string[]']
    args =  [
              [[1, 2], [3]],
              ['one', 'two', 'three']
            ]

   data = hex'0000000000000000000000000000000000000000000000000000000000000040'+
         '0000000000000000000000000000000000000000000000000000000000000140'+
         '0000000000000000000000000000000000000000000000000000000000000002'+
         '0000000000000000000000000000000000000000000000000000000000000040'+
         '00000000000000000000000000000000000000000000000000000000000000a0'+
         '0000000000000000000000000000000000000000000000000000000000000002'+
         '0000000000000000000000000000000000000000000000000000000000000001'+
         '0000000000000000000000000000000000000000000000000000000000000002'+
         '0000000000000000000000000000000000000000000000000000000000000001'+
         '0000000000000000000000000000000000000000000000000000000000000003'+
         '0000000000000000000000000000000000000000000000000000000000000003'+
         '0000000000000000000000000000000000000000000000000000000000000060'+
         '00000000000000000000000000000000000000000000000000000000000000a0'+
         '00000000000000000000000000000000000000000000000000000000000000e0'+
         '0000000000000000000000000000000000000000000000000000000000000003'+
         '6f6e650000000000000000000000000000000000000000000000000000000000'+
         '0000000000000000000000000000000000000000000000000000000000000003'+
         '74776f0000000000000000000000000000000000000000000000000000000000'+
         '0000000000000000000000000000000000000000000000000000000000000005'+
         '7468726565000000000000000000000000000000000000000000000000000000'

  ###
  #  1 - offset of [[1, 2], [3]] points to the start of the content of the array
  #          (64 bytes) - 0x40 (decimal 64 = 2*32)
  #  2 - offset of ["one", "two", "three"]  points to the start of the content of the array
  #          (320 bytes) - 0x140 (decimal 320 = 10*32)
  #  3 - count for [[1, 2], [3]]   - 0x2
  #  4 -  offset of [1, 2]         - 0x40 (decimal 64 = 2*32)
  #  5 -  offset of [3]             - 0xa0 (decimal 160 = 5*32)
  #  6 -  count for [1, 2]         -  0x2
  #  7 -  encoding of 1
  #  8 -  encoding of 2
  #  9 -  count for [3]            - 0x1
  # 10 -  encoding of 3

   assert_bin  data, ABI.encode( types, args )

##  fix: decoding error!!!!  - is now workng???
# Expected: [[[1, 2], [3]], ["one", "two", "three"]]
#  Actual: [[[1, 2], [3]], "\x00\x00\x00"]

  assert_equal args, ABI.decode( types, data )
  assert_equal args, ABI.decode( types, ABI.encode( types, args ))
end

end   ## class TestSpec

