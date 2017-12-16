# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_block_basic.rb


require 'helper'


class TestBlockBasic < MiniTest::Test

def test_example

  block_class = BlockchainLite::Basic::Block

  b0 = block_class.first( 'Genesis' )
  b1 = block_class.next( b0, 'Transaction Data...' )
  b2 = block_class.next( b1, 'Transaction Data...', 'Transaction Data...' )
  b3 = block_class.next( b2 )   ## no transaction data
  b4 = block_class.next( b3, ['Transaction Data...', 'Transaction Data...'] )

  blockchain = [b0, b1, b2, b3, b4]

  pp blockchain

  assert true  ## (for now) everything ok if we get here
end

end  # class TestBlockBasic
