##
#  to run use
#     ruby -I ./lib -I ./test test/test_contract.rb


require 'helper'



class TestContract < MiniTest::Test


RPC       = JsonRpc.new( ENV['INFURA_URI'] )


MARCS_ETH  = "0xe9b91d537c3aa5a3fa87275fbd2e4feaaed69bd0"


def test_tokenURI
   tokenURI   = Ethlite::ContractMethod.new( 'tokenURI',
                                              inputs:  ['uint256'],
                                              outputs: ['string'] )
   ## pp tokenURI

   assert_equal  true, tokenURI.constant
   assert_equal 'tokenURI', tokenURI.name
   assert_equal ['uint256'], tokenURI.input_types.map {|type| type.format }
   assert_equal ['string'], tokenURI.output_types.map {|type| type.format }
   assert_equal 'tokenURI(uint256)', tokenURI.signature
   assert_equal 'c87b56dd', tokenURI.signature_hash

   args = [0]
   res = tokenURI.do_call( RPC, MARCS_ETH, args )
   pp res
end


def test_traitData
   traitData    = Ethlite::ContractMethod.new( 'traitData',
                                                inputs: ['uint256', 'uint256'],
                                                outputs: ['string'] )

   assert_equal  true, traitData.constant
   assert_equal 'traitData', traitData.name
   assert_equal ['uint256', 'uint256'], traitData.input_types.map {|type| type.format }
   assert_equal ['string'], traitData.output_types.map {|type| type.format }
   assert_equal 'traitData(uint256,uint256)', traitData.signature
   assert_equal '09dbabca', traitData.signature_hash

   args = [0,0]
   res = traitData.do_call( RPC, MARCS_ETH, args )
   pp res
end


def test_traitDetails
  traitDetails = Ethlite::ContractMethod.new( 'traitDetails',
                                                 inputs: ['uint256', 'uint256'],
                                                 outputs: ['(string,string,bool)'] )

  assert_equal  true, traitDetails.constant
  assert_equal 'traitDetails', traitDetails.name
  assert_equal ['uint256', 'uint256'], traitDetails.input_types.map {|type| type.format }
  assert_equal ['(string,string,bool)'], traitDetails.output_types.map {|type| type.format }
  assert_equal 'traitDetails(uint256,uint256)', traitDetails.signature
  assert_equal 'ea84b59b', traitDetails.signature_hash


  args = [0,0]
  res = traitDetails.do_call( RPC, MARCS_ETH, args )
  pp res
end


end # class TestContract

