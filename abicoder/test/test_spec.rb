##
#  to run use
#     ruby -I ./lib -I ./test test/test_spec.rb

###
#  try the examples from the official abi spec
#    see https://docs.soliditylang.org/en/develop/abi-spec.html
#
#  plus try the (few) official ethereum abi tests in:
#    https://github.com/ethereum/tests/tree/develop/ABITests
#   for now only available one dataset (that incl. three fixtures)
#    - https://github.com/ethereum/tests/blob/develop/ABITests/basic_abi_tests.json
#
#
#   plus some more from the ethabi (rust)
#    see https://github.com/rust-ethereum/ethabi/blob/master/ethabi/src/encoder.rs
#        https://github.com/rust-ethereum/ethabi/blob/master/ethabi/src/decoder.rs
#

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
  assert_equal args, ABI.decode( types, data )
  assert_equal args, ABI.decode( types, ABI.encode( types, args ))
end


def test_bar   ## bar(bytes3[2])
    types = ['bytes3[2]']
    args =  [['abc'.b,
              'def'.b]]

  data = hex'6162630000000000000000000000000000000000000000000000000000000000' +
            '6465660000000000000000000000000000000000000000000000000000000000'
  assert_bin   data, ABI.encode( types, args )
  assert_equal args, ABI.decode( types, data )
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
  assert_equal args, ABI.decode( types, data )
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
  assert_equal args, ABI.decode( types, data )
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
  assert_equal args, ABI.decode( types, data )
  assert_equal args, ABI.decode( types, ABI.encode( types, args ))
end


####################
##  from ethereum tests
##
def test_single_integer
    types = ['uint256']
    args = [98127491]
    data  = hex'0000000000000000000000000000000000000000000000000000000005d94e83'

    assert_bin   data, ABI.encode( types, args )
    assert_equal args, ABI.decode( types, data )
    assert_equal args, ABI.decode( types, ABI.encode( types, args ))
end


def test_integer_and_address
     ## note:  address gets decoded as a hex(adecimal string) without leading 0x
     ##           e.g. 'cd2a3d9f938e13cd947ec05abc7fe734df8dd826'

     types = [ 'uint256', 'address' ]
     args = [ 324124,
              'cd2a3d9f938e13cd947ec05abc7fe734df8dd826'
            ]
     data = hex'000000000000000000000000000000000000000000000000000000000004f21c' +
               '000000000000000000000000cd2a3d9f938e13cd947ec05abc7fe734df8dd826'

    assert_bin   data, ABI.encode( types, args )
    assert_equal args, ABI.decode( types, data )
    assert_equal args, ABI.decode( types, ABI.encode( types, args ))
end

def test_githubwiki
   types = ['uint256',
            'uint32[]',
            'bytes10',
            'bytes']
   args = [291,
           [1110,1929],
           '1234567890'.b,
           'Hello, world!'.b]
   data = hex'0000000000000000000000000000000000000000000000000000000000000123'+
         '0000000000000000000000000000000000000000000000000000000000000080'+
         '3132333435363738393000000000000000000000000000000000000000000000'+
         '00000000000000000000000000000000000000000000000000000000000000e0'+
         '0000000000000000000000000000000000000000000000000000000000000002'+
         '0000000000000000000000000000000000000000000000000000000000000456'+
         '0000000000000000000000000000000000000000000000000000000000000789'+
         '000000000000000000000000000000000000000000000000000000000000000d'+
         '48656c6c6f2c20776f726c642100000000000000000000000000000000000000'

   assert_bin   data, ABI.encode( types, args )
   assert_equal args, ABI.decode( types, data )
   assert_equal args, ABI.decode( types, ABI.encode( types, args ))
end




def test_hello
  ## sample from ether.js abicoder docu
  types = [ 'uint256', 'string' ]
  args  = [ 1234, 'Hello World' ]
  data =  hex'00000000000000000000000000000000000000000000000000000000000004d2'+
               '0000000000000000000000000000000000000000000000000000000000000040'+
               '000000000000000000000000000000000000000000000000000000000000000b'+
               '48656c6c6f20576f726c64000000000000000000000000000000000000000000'

  assert_bin data, ABI.encode( types, args )
  assert_equal  args, ABI.decode( types, data )
  assert_equal  args, ABI.decode( types, ABI.encode( types, args ))


  ## sample from ether.js abicoder docu
  types = [ 'uint256[]', 'string' ]
  args  = [ [1234, 5678] , 'Hello World' ]
  data = hex'0000000000000000000000000000000000000000000000000000000000000040'+
               '00000000000000000000000000000000000000000000000000000000000000a0'+
               '0000000000000000000000000000000000000000000000000000000000000002'+
               '00000000000000000000000000000000000000000000000000000000000004d2'+
               '000000000000000000000000000000000000000000000000000000000000162e'+
               '000000000000000000000000000000000000000000000000000000000000000b'+
               '48656c6c6f20576f726c64000000000000000000000000000000000000000000'

  assert_bin data, ABI.encode( types, args )
  assert_equal  args, ABI.decode( types, data )
  assert_equal  args, ABI.decode( types, ABI.encode( types, args ))
end


def test_tuples

  ## sample from ether.js abicoder docu
  types = [ 'uint256', '(uint256,string)']
  args = [1234, [5678, 'Hello World']]
   data = hex'00000000000000000000000000000000000000000000000000000000000004d2'+
          '0000000000000000000000000000000000000000000000000000000000000040'+
          '000000000000000000000000000000000000000000000000000000000000162e'+
          '0000000000000000000000000000000000000000000000000000000000000040'+
          '000000000000000000000000000000000000000000000000000000000000000b'+
          '48656c6c6f20576f726c64000000000000000000000000000000000000000000'

  assert_bin data, ABI.encode( types, args )
  assert_equal args, ABI.decode( types, data )
  assert_equal args, ABI.decode( types, ABI.encode( types, args ))


  #####
  ## reported encoding bug from eth.rb
  ##   see https://github.com/q9f/eth.rb/issues/102#
  types = ['uint256', '(address,uint256)[]', 'string']
   args  =  [66,
             [["18a475d6741215709ed6cc5f4d064732379b5a58", 1]],
               "QmWBiSE9ByR6vrx4hvrjqS3SG5r6wE4SRq7CP2RVpafZWV"]
   data = hex'0000000000000000000000000000000000000000000000000000000000000042'+
             '0000000000000000000000000000000000000000000000000000000000000060'+
             '00000000000000000000000000000000000000000000000000000000000000c0'+
             '0000000000000000000000000000000000000000000000000000000000000001'+
             '00000000000000000000000018a475d6741215709ed6cc5f4d064732379b5a58'+
             '0000000000000000000000000000000000000000000000000000000000000001'+
             '000000000000000000000000000000000000000000000000000000000000002e'+
             '516d57426953453942795236767278346876726a715333534735723677453453'+
             '52713743503252567061665a5756000000000000000000000000000000000000'

   assert_bin data, ABI.encode( types, args )
   assert_equal args, ABI.decode( types, data )
   assert_equal args, ABI.decode( types, ABI.encode( types, args ))
end

end   ## class TestSpec

