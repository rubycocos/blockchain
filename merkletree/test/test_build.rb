# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_build.rb


require 'helper'


class TestBuild < MiniTest::Test


def test_example_4

  hashes = [
    '00',
    '11',
    '22',
    '33',
  ]

  hash00   = '00'
  hash11   = '11'
  hash0011 = MerkleTree.calc_hash( hash00 + hash11 )

  hash22   = '22'
  hash33   = '33'
  hash2233 = MerkleTree.calc_hash( hash22 + hash33 )

  hash00112233 = MerkleTree.calc_hash( hash0011 + hash2233 )


  merkle = MerkleTree.new( hashes )

  puts "merkletree root hash:"
  puts merkle.root.value

  puts "merkletree:"
  pp merkle.root

  assert_equal hash00, merkle.root.left.left.value
  assert_equal hash11, merkle.root.left.right.value
  assert_equal hash22, merkle.root.right.left.value
  assert_equal hash33, merkle.root.right.right.value

  assert_equal hash0011, merkle.root.left.value
  assert_equal hash2233, merkle.root.right.value

  assert_equal hash00112233, merkle.root.value



  merkle_root_value = MerkleTree.compute_root( hashes )
  puts "merkletree root hash:"
  puts merkle_root_value

  assert_equal merkle.root.value, merkle_root_value
end   # method test_example_4


def test_example_3   ## test odd (not even hashes)

  hashes = [
    '00',
    '11',
    '22',
  ]

  hash00   = '00'
  hash11   = '11'
  hash0011 = MerkleTree.calc_hash( hash00 + hash11 )

  hash22   = '22'
  hash2222 = MerkleTree.calc_hash( hash22 + hash22 )

  hash00112222 = MerkleTree.calc_hash( hash0011 + hash2222 )


  merkle = MerkleTree.new( hashes )

  puts "merkletree root hash:"
  puts merkle.root.value

  ## try handcoded pretty printer (dump)
  merkle.root.dump

  puts "merkletree:"
  pp merkle.root

  assert_equal hash00, merkle.root.left.left.value
  assert_equal hash11, merkle.root.left.right.value
  assert_equal hash22, merkle.root.right.left.value
  assert_equal hash22, merkle.root.right.right.value

  assert_equal hash0011, merkle.root.left.value
  assert_equal hash2222, merkle.root.right.value

  assert_equal hash00112222, merkle.root.value



  merkle_root_value = MerkleTree.compute_root( hashes )
  puts "merkletree root hash:"
  puts merkle_root_value

  assert_equal merkle.root.value, merkle_root_value
end   # method test_example_3


def test_example_5   ## test odd (not even hashes)

  hashes = [
    '0000',
    '0011',
    '0022',
    '0033',
    '0044',
  ]

  merkle = MerkleTree.new( hashes )

  puts "merkletree root hash:"
  puts merkle.root.value

  puts "merkletree:"
  pp merkle.root

  ## try handcoded pretty printer (dump)
  merkle.root.dump


  merkle_root_value = MerkleTree.compute_root( hashes )
  puts "merkletree root hash:"
  puts merkle_root_value

  assert_equal merkle.root.value, merkle_root_value
end   # method test_example_5


def test_tulips

  merkle = MerkleTree.for(
        { from: "Dutchgrown", to: "Vincent", what: "Tulip Bloemendaal Sunset", qty: 10 },
        { from: "Keukenhof",  to: "Anne",    what: "Tulip Semper Augustus",    qty: 7  } )

  puts "merkletree root hash:"
  puts merkle.root.value

  puts "merkletree:"
  pp merkle.root

  merkle_root_value = MerkleTree.compute_root_for(
    { from: "Dutchgrown", to: "Vincent", what: "Tulip Bloemendaal Sunset", qty: 10 },
    { from: "Keukenhof",  to: "Anne",    what: "Tulip Semper Augustus",    qty: 7  } )

  puts "merkletree root hash:"
  puts merkle_root_value

  assert_equal merkle.root.value, merkle_root_value
end  # method test_tulips


end  # class TestBuild
