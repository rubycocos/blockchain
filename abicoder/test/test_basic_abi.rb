##
#  to run use
#     ruby -I ./lib -I ./test test/test_basic_abi.rb

###
#  try the (few) official ethereum abi tests in:
#    https://github.com/ethereum/tests/tree/develop/ABITests
#   for now only available one dataset (that incl. three fixtures)
#    - https://github.com/ethereum/tests/blob/develop/ABITests/basic_abi_tests.json

require 'helper'


class TestBasicAbi < MiniTest::Test

def test_single_integer
    types = ['uint256']
    args = [98127491]
    data  = hex'0000000000000000000000000000000000000000000000000000000005d94e83'

    assert_equal data, ABI.encode( types, args )
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

    assert_equal data, ABI.encode( types, args )
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

   assert_equal data, ABI.encode( types, args )
   assert_equal args, ABI.decode( types, data )
   assert_equal args, ABI.decode( types, ABI.encode( types, args ))
end


end   ## class TestBasicAbi