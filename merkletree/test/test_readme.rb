# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_readme.rb


require 'helper'


class TestReadme < MiniTest::Test


def xxx_test_hashes

  merkle1 = MerkleTree.new(
    'eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743',
    'edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b',
    '5ee2981606328abfe0c3b1171440f0df746c1e1f8b3b56c351727f7da7ae5d8d' )

  # -or-

  puts merkle1.root.value
  pp merkle1

  merkle2 = MerkleTree.new( [
    'eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743',
    'edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b',
    '5ee2981606328abfe0c3b1171440f0df746c1e1f8b3b56c351727f7da7ae5d8d' ])

  pp merkle2
  puts merkle2.root.value

  assert_equal merkle1.root.value, merkle2.root.value


  merkle_root_value = MerkleTree.compute_root(
    'eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743',
    'edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b',
    '5ee2981606328abfe0c3b1171440f0df746c1e1f8b3b56c351727f7da7ae5d8d' )

  puts merkle_root_value

  assert_equal merkle1.root.value, merkle_root_value
end # method test_hashes



def test_transactions

  merkle = MerkleTree.for(
    { from: "Bloom & Blossom", to: "Daisy",   what: "Tulip Admiral of Admirals", qty: 8 },
    { from: "Vincent",         to: "Max",     what: "Tulip Bloemendaal Sunset",  qty: 2 },
    { from: "Anne",            to: "Martijn", what: "Tulip Semper Augustus",     qty: 2 },
    { from: "Ruben",           to: "Julia",   what: "Tulip Admiral van Eijck",   qty: 2 } )

  puts 'merkle tree root hash:'
  puts merkle.root.value
  pp merkle

  merkle_root_value = MerkleTree.compute_root_for(
    { from: "Bloom & Blossom", to: "Daisy",   what: "Tulip Admiral of Admirals", qty: 8 },
    { from: "Vincent",         to: "Max",     what: "Tulip Bloemendaal Sunset",  qty: 2 },
    { from: "Anne",            to: "Martijn", what: "Tulip Semper Augustus",     qty: 2 },
    { from: "Ruben",           to: "Julia",   what: "Tulip Admiral van Eijck",   qty: 2 } )

  puts 'merkle tree root hash:'
  puts merkle_root_value

  assert_equal merkle.root.value, merkle_root_value
end  # method test_transactions


end # class TestReadme
