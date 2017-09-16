
require 'helper'


class TestVersion < MiniTest::Test

def test_version
   pp BlockchainLite.version
   pp BlockchainLite.banner
   pp BlockchainLite.root

   assert true  ## (for now) everything ok if we get here
end

def test_example

  b0 = Block.first( "Genesis" )
  b1 = Block.next( b0, "Transaction Data..." )
  b2 = Block.next( b1, "Transaction Data......" )
  b3 = Block.next( b2, "More Transaction Data..." )

  blockchain = [b0, b1, b2, b3]

  pp blockchain

  assert true  ## (for now) everything ok if we get here
end

end  # class TestVersion
