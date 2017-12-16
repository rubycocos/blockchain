# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_block.rb


require 'helper'


class TestBlock < MiniTest::Test

def test_version
   pp BlockchainLite.version
   pp BlockchainLite.banner
   pp BlockchainLite.root

   assert true  ## (for now) everything ok if we get here
end

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

def test_tulips_example
  b0 = Block.first(
        { from: "Dutchgrown", to: "Vincent", what: "Tulip Bloemendaal Sunset", qty: 10 },
        { from: "Keukenhof",  to: "Anne",    what: "Tulip Semper Augustus",    qty: 7  } )

  b1 = Block.next( b0,
        { from: "Flowers", to: "Ruben", what: "Tulip Admiral van Eijck",  qty: 5 },
        { from: "Vicent",  to: "Anne",  what: "Tulip Bloemendaal Sunset", qty: 3 },
        { from: "Anne",    to: "Julia", what: "Tulip Semper Augustus",    qty: 1 },
        { from: "Julia",   to: "Luuk",  what: "Tulip Semper Augustus",    qty: 1 } )

  b2 = Block.next( b1,
        { from: "Bloom & Blossom", to: "Daisy",   what: "Tulip Admiral of Admirals", qty: 8 },
        { from: "Vincent",         to: "Max",     what: "Tulip Bloemendaal Sunset",  qty: 2 },
        { from: "Anne",            to: "Martijn", what: "Tulip Semper Augustus",     qty: 2 },
        { from: "Ruben",           to: "Julia",   what: "Tulip Admiral van Eijck",   qty: 2 } )

  blockchain = [b0, b1, b2]

  pp blockchain

  assert true  ## (for now) everything ok if we get here
end

end  # class TestBlock
