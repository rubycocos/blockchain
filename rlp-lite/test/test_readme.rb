##
#  to run use
#     ruby -I ./lib -I ./test test/test_readme.rb


require 'helper'



class TestRlp < MiniTest::Test

  def test_sample

## encode

  list =  ['ruby', 'rlp', 255]

  encoded = Rlp.encode( list )

  pp encoded
  assert_equal "\xCB\x84ruby\x83rlp\x81\xFF".b, encoded


## decode

  list_encoded = "\xCB\x84ruby\x83rlp\x81\xFF".b

  decoded = Rlp.decode( list_encoded )

  pp decoded
  assert_equal ["ruby", "rlp", "\xFF".b], decoded



###
   s = Rlp::Sedes.infer( list )
  pp s


### more

# listsoflists
obj = [ [ [], [] ], [] ]
encoded = Rlp.encode( obj )
pp encoded

decoded =  Rlp.decode( "\xC4\xC2\xC0\xC0\xC0".b )
pp decoded

decoded =  Rlp.decode( "0xc4c2c0c0c0" )
pp decoded



# dict
obj = [["key1", "val1"],
       ["key2", "val2"],
       ["key3", "val3"],
       ["key4", "val4"]]
encoded = Rlp.encode( obj )
pp encoded

decoded = Rlp.decode( "\xEC\xCA\x84key1\x84val1\xCA\x84key2\x84val2\xCA\x84key3\x84val3\xCA\x84key4\x84val4".b )
pp decoded

decoded = Rlp.decode( "0xecca846b6579318476616c31ca846b6579328476616c32ca846b6579338476616c33ca846b6579348476616c34" )
pp decoded



end



end