##
#  to run use
#     ruby -I ./lib -I ./test test/test_parser.rb


require 'helper'



class TestParser < MiniTest::Test

  CONTRACTS = {
    contract1: {
      outline: "contract SimpleAuction\n",
      pragmas: "pragma solidity >=0.7.0 <0.9.0;\n",
    },
    contract2: {
      outline: "contract Indelible is ERC721A, ReentrancyGuard, Ownable\n" +
               "library DynamicBuffer\n" +
               "library HelperLib\n" +
               "library SSTORE2\n" +
               "library Bytecode\n" +
               "library Address\n" +
               "library Base64\n" +
               "library MerkleProof\n" +
               "interface ERC721A__IERC721Receiver\n" +
               "contract ERC721A is IERC721A\n" +
               "interface IERC721A\n",
      pragmas: "",
    },
    contract3: {
      outline: "contract owned\n" +
               "contract Destructible is owned\n" +
               "contract Base1 is Destructible\n" +
               "contract Base2 is Destructible\n" +
               "contract Final is Base1, Base2\n",
      pragmas: "pragma solidity >=0.7.0 <0.9.0;\n",
    },
    contract7: {
      outline: "contract Moonbirds\n",
      pragmas: "pragma solidity >=0.8.10 <0.9.0;\n",
    },
  }


 def test_contracts
   CONTRACTS.each do |name, exp|
     path = "./contracts/#{name}.sol"
     parser = Solidity::Parser.read( path )

     assert_equal exp[:outline], parser.outline
     assert_equal exp[:pragmas], parser.pragmas
   end
 end

end   ## class TestParser

