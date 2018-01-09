# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_blockchain.rb

require 'helper'


class TestBlockchain < MiniTest::Test

include ProofOfWork   ## adds:
                      ##   Block = BlockchainLite::ProofOfWork::Block etc.
                      ##   class Blockchain < BlockchainLite::Blockchain
                      ##      def block_class() Block; end
                      ##   end


def test_new

  b = Blockchain.new

  b << 'Genesis'
  b << 'Transaction Data...'
  b << ['Transaction Data...']
  b << ['Transaction Data...', 'Transaction Data...']
  b << []   ## empty block (no transactions)

  ## add do-it-yourself built block
  b << Block.next( b.last, 'Transaction Data...' )

  b << 'Transaction Data...'

  pp b

  assert true  ## (for now) everything ok if we get here
end


def test_wrap

  b0 = Block.first( 'Genesis' )
  b1 = Block.next( b0, 'Transaction Data...' )
  b2 = Block.next( b1, 'Transaction Data...' )
  b3 = Block.next( b2, 'Transaction Data...' )
  blockchain = [b0, b1, b2, b3]

  b = Blockchain.new( blockchain )
  puts "broken? #{b.broken?}"
  puts "valid?  #{b.valid?}"

  pp b

  assert_equal false, b.broken?
  assert_equal true,  b.valid?

  ## corrupt data in block in chain
  b2.instance_eval <<RUBY
     @transactions      = ['xxxxxx']
     @transactions_hash = MerkleTree.compute_root_for( @transactions )
RUBY

  assert_equal true,   b.broken?
  assert_equal false,  b.valid?

  pp b
end


end  # class TestBlockchain
