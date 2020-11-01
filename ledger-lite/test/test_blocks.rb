# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_blocks.rb


require 'helper'


class TestBlocks < MiniTest::Test

include V1    # includes Ledger, Tx, etc.

def setup
  Ledger.configure do |config|
     config.coinbase = ["Keukenhof†", "Dutchgrown†"]
  end
end

def test_blocks_with_hash

  b0 = Block.new( { from: "Keukenhof†", to: "Vincent",    amount: 11 },
                  { from: "Vincent",    to: "Anne",       amount:  3 },
                  { from: "Anne",       to: "Julia",      amount:  2 },
                  { from: "Julia",      to: "Luuk",       amount:  1 } )

  b1 = Block.new( { from: "Dutchgrown†", to: "Ruben",   amount: 11 },
                  { from: "Vincent",     to: "Max",     amount:  3 },
                  { from: "Ruben",       to: "Julia",   amount:  2 },
                  { from: "Anne",        to: "Martijn", amount:  1 } )

  blockchain = [b0,b1]

  ledger = Ledger.new( blockchain )

  pp ledger

  balances = {"Vincent"=>5,
              "Anne"=>0,
              "Julia"=>3,
              "Luuk"=>1,
              "Ruben"=>9,
              "Max"=>3,
              "Martijn"=>1}
  assert_equal balances, ledger.addr
end


def test_blocks_with_tx_v1

  b0 = Block.new( Tx.new( from: "Keukenhof†", to: "Vincent", amount: 11 ),
                  Tx.new( from: "Vincent",    to: "Anne",    amount:  3 ),
                  Tx.new( from: "Anne",       to: "Julia",   amount:  2 ),
                  Tx.new( from: "Julia",      to: "Luuk",    amount:  1 ))

  b1 = Block.new( Tx.new( from: "Dutchgrown†", to: "Ruben",   amount: 11 ),
                  Tx.new( from: "Vincent",     to: "Max",     amount:  3 ),
                  Tx.new( from: "Ruben",       to: "Julia",   amount:  2 ),
                  Tx.new( from: "Anne",        to: "Martijn", amount:  1 ))

  blockchain = [b0,b1]

  ledger = Ledger.new( blockchain )

  pp ledger

  balances = {"Vincent"=>5,
              "Anne"=>0,
              "Julia"=>3,
              "Luuk"=>1,
              "Ruben"=>9,
              "Max"=>3,
              "Martijn"=>1}
  assert_equal balances, ledger.addr
end



def test_blocks_with_tx_v2

  b0 = Block.new( Tx.new( "Keukenhof†", "Vincent", 11 ),
                  Tx.new( "Vincent",    "Anne",     3 ),
                  Tx.new( "Anne",       "Julia",    2 ),
                  Tx.new( "Julia",      "Luuk",     1 ))

  b1 = Block.new( Tx.new( "Dutchgrown†", "Ruben", 11 ),
                  Tx.new( "Vincent", "Max",        3 ),
                  Tx.new( "Ruben",   "Julia",      2 ),
                  Tx.new( "Anne",    "Martijn",    1 ))

  blockchain = [b0,b1]

  ledger = Ledger.new( blockchain )

  pp ledger

  balances = {"Vincent"=>5,
              "Anne"=>0,
              "Julia"=>3,
              "Luuk"=>1,
              "Ruben"=>9,
              "Max"=>3,
              "Martijn"=>1}
  assert_equal balances, ledger.addr
end


end  # class TestBlocks
