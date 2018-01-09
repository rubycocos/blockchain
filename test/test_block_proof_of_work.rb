# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_block_proof_of_work.rb


require 'helper'


class TestBlockProofOfWork < MiniTest::Test

include ProofOfWork   ## adds Block = BlockchainLite::ProofOfWork::Block etc.


def test_example

  b0 = Block.first( 'Genesis' )
  b1 = Block.next( b0, 'Transaction Data...' )
  b2 = Block.next( b1, 'Transaction Data...', 'Transaction Data...' )
  b3 = Block.next( b2 )   ## no transaction data
  b4 = Block.next( b3, ['Transaction Data...', 'Transaction Data...'] )

  blockchain = [b0, b1, b2, b3, b4]

  pp blockchain

  assert true  ## (for now) everything ok if we get here
end

end  # class TestBlockProofOfWork
