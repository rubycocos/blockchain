##
#  to run use
#     ruby -I ./lib -I ./test test/test_digest.rb


require 'helper'



class TestDigest < MiniTest::Test

  KECCAK256_TESTS = [
   ['',                'c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470'],
   ['testing',         '5f16f4c7f149ac4f9510d9cf8cf384038ad348b3bcdc01915f95de12df9d1b02'],
   ['Hello, Cryptos!', '2cf14baa817e931f5cc2dcb63c889619d6b7ae0794fc2223ebadf8e672c776f5'],
   ['cat',             '52763589e772702fa7977a28b3cfb6ca534f0208a2b2d55f7558af664eac478a'],
 ]


 SHA3_224_TESTS = [
   ['',                '6b4e03423667dbb73b6e15454f0eb1abd4597f9a1b078e3f5b5a6bc7'],
   ['cat',             '447c857980c93d613b8bd6897c05bfd0621245139f021aaa6b57830a'],
   ['example 224-bit', '89354196ffd570c33c70a37da19b55a9761a3ae178488ee1345b7fae' ],
   ['another way',     '2e250b541367f0f86bbc6f701fb2bcd8e85c159497805580eae989e1' ],
]

 SHA3_256_TESTS = [
   ['',                'a7ffc6f8bf1ed76651c14756a061d662f580ff4de43b49fa82d80a4b80f8434a'],
   ['Hello, Cryptos!', '7dddf4bc9b86352b67e8823e5010ddbd2a90a854469e2517992ca7ca89e5bd58'],
   ['cat',             'd616607d3e4ba96a74f323cffc5f20a3c78e7cab8ecbdbb03b13fa8ffc9bf644'],
 ]

 SHA3_384_TESTS = [
   ['',        '0c63a75b845e4f7d01107d852e4c2485c51a50aaaa94fc61995e71bbee983a2ac3713831264adb47fb6bd1e058d5f004'],
   ['cat',     '9bb4adf3004b3ed61f76195321621eac835b6502db486a53b64fdb69c50ee1a8dbb05c950577db70be2bafed59f8891d'],
 ]

 SHA3_512_TESTS = [
   ['',                'a69f73cca23a9ac5c8b567dc185a756e97c982164fe25859e0d1dcc1475c80a615b2123af1f5f94c11e3e9402c3ac558f500199d95b6d3e301758586281dcd26'],
   ['cat',             'fe37dd66fa849ca98684160d542538b22c1edb576271d76b319ded4965d90143a0806fe1edf29b82b8740ec177880769629bdd1a0fb7cb97d7640e60c44833d3'],
   ['default 512-bit', '561ac4ec3e6bc5d3bb8a19e440441d2482d94c3932896c11c62177d1bccd8d25022ba68b8b0344c0a3fac4af5c06a17ae4372b76653c2230bae5240cde92cc55'],
 ]


  def test_keccak256
    KECCAK256_TESTS.each do |item|
      ## note: force string encoding to binary (via #b) !!!
      assert_equal item[1], Digest::KeccakLite.new( 256 ).hexdigest( item[0].b )
      assert_equal item[1], Digest::KeccakLite.hexdigest( item[0].b, 256 )
    end
  end



  def test_sha3_224
    SHA3_224_TESTS.each do |item|
      ## note: force string encoding to binary (via #b) !!!
      assert_equal item[1], Digest::SHA3Lite.new( 224 ).hexdigest( item[0].b )
      assert_equal item[1], Digest::SHA3Lite.hexdigest( item[0].b, 224 )
    end
  end

  def test_sha3_256
    SHA3_256_TESTS.each do |item|
      ## note: force string encoding to binary (via #b) !!!
      assert_equal item[1], Digest::SHA3Lite.new( 256 ).hexdigest( item[0].b )
      assert_equal item[1], Digest::SHA3Lite.hexdigest( item[0].b, 256 )
    end
  end

  def test_sha3_384
    SHA3_384_TESTS.each do |item|
      ## note: force string encoding to binary (via #b) !!!
      assert_equal item[1], Digest::SHA3Lite.new( 384 ).hexdigest( item[0].b )
      assert_equal item[1], Digest::SHA3Lite.hexdigest( item[0].b, 384 )
    end
  end

  def test_sha3_512
    SHA3_512_TESTS.each do |item|
      ## note: force string encoding to binary (via #b) !!!
      ##  note: hash_size (in bits) defaults to 512 (in SHA3 "family")
      assert_equal item[1], Digest::SHA3Lite.new.hexdigest( item[0].b )
      assert_equal item[1], Digest::SHA3Lite.hexdigest( item[0].b )

      assert_equal item[1], Digest::SHA3Lite.new( 512 ).hexdigest( item[0].b )
      assert_equal item[1], Digest::SHA3Lite.hexdigest( item[0].b, 512 )
    end
  end

end   # TestDigest

