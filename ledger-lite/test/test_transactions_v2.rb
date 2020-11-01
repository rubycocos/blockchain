# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_transactions_v2.rb


require 'helper'


class TestTransactionsV2 < MiniTest::Test

include V2    # includes Ledger, Tx, etc.

def setup
  Ledger.configure do |config|
    ## note: for testing use different coinbase than "classic / standard" V1 version
    config.coinbase = ["Flowers†", "Bloom & Blossom†"]
  end
end



def test_send

  ledger = Ledger.new

  ledger.send( "Flowers†",         "Vincent", 11, "Tulip Admiral van Eijck" )
  ledger.send( "Vincent",          "Anne",     3, "Tulip Admiral van Eijck" )
  ledger.send( "Anne",             "Julia",    2, "Tulip Admiral van Eijck" )
  ledger.send( "Julia",            "Luuk",     1, "Tulip Admiral van Eijck" )

  ledger.send( "Bloom & Blossom†", "Ruben",   11, "Tulip Semper Augustus"  )
  ledger.send( "Vincent",          "Max",      3, "Tulip Admiral van Eijck" )
  ledger.send( "Ruben",            "Julia",    2, "Tulip Semper Augustus" )
  ledger.send( "Anne",             "Martijn",  1, "Tulip Admiral van Eijck" )

  pp ledger

  balances = {"Vincent"=>{"Tulip Admiral van Eijck"=>5},
              "Anne"=>{"Tulip Admiral van Eijck"=>0},
              "Julia"=>{"Tulip Admiral van Eijck"=>1, "Tulip Semper Augustus"=>2},
              "Luuk"=>{"Tulip Admiral van Eijck"=>1},
              "Ruben"=>{"Tulip Semper Augustus"=>9},
              "Max"=>{"Tulip Admiral van Eijck"=>3},
              "Martijn"=>{"Tulip Admiral van Eijck"=>1}}

  assert_equal balances, ledger.addr
end


def test_with_tx

  ledger = Ledger.new

  ledger.write( Tx.new( "Flowers†",         "Vincent",  11, "Tulip Admiral van Eijck" ))
  ledger.write( Tx.new( "Vincent",          "Anne",     3, "Tulip Admiral van Eijck" ))

  ledger <<     Tx.new( "Anne",             "Julia",    2, "Tulip Admiral van Eijck" )
  ledger <<     Tx.new( "Julia",            "Luuk",     1, "Tulip Admiral van Eijck" )


  ledger.write( Tx.new( "Bloom & Blossom†", "Ruben",   11, "Tulip Semper Augustus" ),
                Tx.new( "Vincent",          "Max",      3, "Tulip Admiral van Eijck" ),
                Tx.new( "Ruben",            "Julia",    2, "Tulip Semper Augustus" ),
                Tx.new( "Anne",             "Martijn",  1, "Tulip Admiral van Eijck" ))

  pp ledger

  balances = {"Vincent"=>{"Tulip Admiral van Eijck"=>5},
              "Anne"=>{"Tulip Admiral van Eijck"=>0},
              "Julia"=>{"Tulip Admiral van Eijck"=>1, "Tulip Semper Augustus"=>2},
              "Luuk"=>{"Tulip Admiral van Eijck"=>1},
              "Ruben"=>{"Tulip Semper Augustus"=>9},
              "Max"=>{"Tulip Admiral van Eijck"=>3},
              "Martijn"=>{"Tulip Admiral van Eijck"=>1}}

  assert_equal balances, ledger.addr
end


def test_with_hash

  ledger = Ledger.new

  ledger.write( { from: "Flowers†",         to: "Vincent",  qty: 11, name: "Tulip Admiral van Eijck" },
                { from: "Vincent",          to: "Anne",     qty:  3, name: "Tulip Admiral van Eijck" },
                { from: "Anne",             to: "Julia",    qty:  2, name: "Tulip Admiral van Eijck" },
                { from: "Julia",            to: "Luuk",     qty:  1, name: "Tulip Admiral van Eijck" })

  ledger.write( { from: "Bloom & Blossom†", to: "Ruben",    qty: 11, name: "Tulip Semper Augustus"  },
                { from: "Vincent",          to: "Max",      qty:  3, name: "Tulip Admiral van Eijck" },
                { from: "Ruben",            to: "Julia",    qty:  2, name: "Tulip Semper Augustus" },
                { from: "Anne",             to: "Martijn",  qty:  1, name: "Tulip Admiral van Eijck" })

  pp ledger

  balances = {"Vincent"=>{"Tulip Admiral van Eijck"=>5},
              "Anne"=>{"Tulip Admiral van Eijck"=>0},
              "Julia"=>{"Tulip Admiral van Eijck"=>1, "Tulip Semper Augustus"=>2},
              "Luuk"=>{"Tulip Admiral van Eijck"=>1},
              "Ruben"=>{"Tulip Semper Augustus"=>9},
              "Max"=>{"Tulip Admiral van Eijck"=>3},
              "Martijn"=>{"Tulip Admiral van Eijck"=>1}}

  assert_equal balances, ledger.addr
end

end  # class TestTransactionsV2
