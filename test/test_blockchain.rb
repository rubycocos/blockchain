# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_blockchain.rb

require 'helper'


class TestBlockchain < MiniTest::Test

def test_new

  b = Blockchain.new

  b << 'Transaction Data...'

  ## add do-it-yourself built block
  b << Block.next( b.last, 'Transaction Data......' )

  b << 'More Transaction Data...'

  pp b

  assert true  ## (for now) everything ok if we get here
end


def test_with_block_class

  b = Blockchain.new( block_class: BlockchainLite::Basic::Block )

  b << 'Transaction Data...'
  b << 'Transaction Data......'
  b << 'More Transaction Data...'

  pp b

  assert true  ## (for now) everything ok if we get here
end


def test_wrap

  b0 = Block.first( 'Genesis' )
  b1 = Block.next( b0, 'Transaction Data...' )
  b2 = Block.next( b1, 'Transaction Data......' )
  b3 = Block.next( b2, 'More Transaction Data...' )
  blockchain = [b0, b1, b2, b3]

  b = Blockchain.new( blockchain )
  puts "broken? #{b.broken?}"
  puts "valid?  #{b.valid?}"

  pp b

  assert_equal false, b.broken?
  assert_equal true,  b.valid?

  ## corrupt data in block in chain
  b2.instance_eval %{ @data='XXXXXXX' }

  assert_equal true,   b.broken?
  assert_equal false,  b.valid?

  pp b
end


end  # class TestBlockchain
