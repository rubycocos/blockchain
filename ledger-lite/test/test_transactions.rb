# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_transactions.rb


require 'helper'


class TestTransactions < MiniTest::Test

include V1    # includes Ledger, Tx, etc.

def setup
  Ledger.configure do |config|
    config.coinbase = ["Keukenhof†", "Dutchgrown†"]
  end
end


def test_send

  ledger = Ledger.new

  ledger.send( "Keukenhof†",  "Vincent", 11 )
  ledger.send( "Vincent",     "Anne",     3 )
  ledger.send( "Anne",        "Julia",    2 )
  ledger.send( "Julia",       "Luuk",     1 )

  ledger.send( "Dutchgrown†", "Ruben",   11 )
  ledger.send( "Vincent",     "Max",      3 )
  ledger.send( "Ruben",       "Julia",    2 )
  ledger.send( "Anne",        "Martijn",  1 )

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


def test_with_tx_v1

  ledger = Ledger.new

  ledger.write( Tx.new( "Keukenhof†",  "Vincent", 11 ))
  ledger.write( Tx.new( "Vincent",     "Anne",     3 ))
  ledger.write( Tx.new( "Anne",        "Julia",    2 ))
  ledger.write( Tx.new( "Julia",       "Luuk",     1 ))

  ledger.write( Tx.new( "Dutchgrown†", "Ruben",   11 ))
  ledger.write( Tx.new( "Vincent",     "Max",      3 ))
  ledger.write( Tx.new( "Ruben",       "Julia",    2 ))
  ledger.write( Tx.new( "Anne",        "Martijn",  1 ))

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


def test_with_tx_v2

  ledger = Ledger.new

  ledger.write( Tx.new( "Keukenhof†",  "Vincent", 11 ),
                Tx.new( "Vincent",     "Anne",     3 ),
                Tx.new( "Anne",        "Julia",    2 ),
                Tx.new( "Julia",       "Luuk",     1 ))

  ledger.write( Tx.new( "Dutchgrown†", "Ruben",   11 ),
                Tx.new( "Vincent",     "Max",      3 ),
                Tx.new( "Ruben",       "Julia",    2 ),
                Tx.new( "Anne",        "Martijn",  1 ))

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


def test_with_tx_v3

  ledger = Ledger.new

  ledger << Tx.new( "Keukenhof†",  "Vincent", 11 )
  ledger << Tx.new( "Vincent",     "Anne",     3 )
  ledger << Tx.new( "Anne",        "Julia",    2 )
  ledger << Tx.new( "Julia",       "Luuk",     1 )

  ledger << [Tx.new( "Dutchgrown†", "Ruben",   11 ),
             Tx.new( "Vincent",     "Max",      3 ),
             Tx.new( "Ruben",       "Julia",    2 ),
             Tx.new( "Anne",        "Martijn",  1 )]

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



def test_with_hash

  ledger = Ledger.new

  ledger.write( { from: "Keukenhof†", to: "Vincent",  amount: 11 },
                { from: "Vincent",    to: "Anne",     amount:  3 },
                { from: "Anne",       to: "Julia",    amount:  2 },
                { from: "Julia",      to: "Luuk",     amount:  1 })

  ledger.write( { from: "Dutchgrown†", to: "Ruben",   amount: 11 },
                { from: "Vincent",     to: "Max",     amount:  3 },
                { from: "Ruben",       to: "Julia",   amount:  2 },
                { from: "Anne",        to: "Martijn", amount:  1 })

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


end  # class TestTransactions
