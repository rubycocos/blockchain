# PhunksV2 contract / (blockchain) services / function calls
#
#  auto-generated via abigen (see https://rubygems.org/gems/abigen) on 2023-01-15 16:36:46 UTC
#  - 22 query functions(s)
#  - 0 helper functions(s)


class  PhunksV2 <  Ethlite::Contract

  address "0xf07468ead8cf26c752c676e43c814fee9c8cf402"

#  function **MAX_MINTABLE_AT_ONCE**() ⇒ (uint256 _) _readonly_
def MAX_MINTABLE_AT_ONCE()
  do_call("MAX_MINTABLE_AT_ONCE")
end
sig "MAX_MINTABLE_AT_ONCE", outputs: ["uint256"]

#  function **balanceOf**(address owner) ⇒ (uint256 _) _readonly_
def balanceOf(owner)
  do_call("balanceOf", owner)
end
sig "balanceOf", inputs: ["address"], outputs: ["uint256"]

#  function **contractURI**() ⇒ (string _) _readonly_
def contractURI()
  do_call("contractURI")
end
sig "contractURI", outputs: ["string"]

#  function **freeRollPhunks**(address _) ⇒ (uint256 _) _readonly_
def freeRollPhunks(arg0)
  do_call("freeRollPhunks", arg0)
end
sig "freeRollPhunks", inputs: ["address"], outputs: ["uint256"]

#  function **getApproved**(uint256 tokenId) ⇒ (address _) _readonly_
def getApproved(tokenId)
  do_call("getApproved", tokenId)
end
sig "getApproved", inputs: ["uint256"], outputs: ["address"]

#  function **getCostForMintingPhunks**(uint256 _numToMint) ⇒ (uint256 _) _readonly_
def getCostForMintingPhunks(_numToMint)
  do_call("getCostForMintingPhunks", _numToMint)
end
sig "getCostForMintingPhunks", inputs: ["uint256"], outputs: ["uint256"]

#  function **getNumFreeRollPhunks**(address owner) ⇒ (uint256 _) _readonly_
def getNumFreeRollPhunks(owner)
  do_call("getNumFreeRollPhunks", owner)
end
sig "getNumFreeRollPhunks", inputs: ["address"], outputs: ["uint256"]

#  function **getPhunksBelongingToOwner**(address _owner) ⇒ (uint256[] _) _readonly_
def getPhunksBelongingToOwner(_owner)
  do_call("getPhunksBelongingToOwner", _owner)
end
sig "getPhunksBelongingToOwner", inputs: ["address"], outputs: ["uint256[]"]

#  function **imageHash**() ⇒ (string _) _readonly_
def imageHash()
  do_call("imageHash")
end
sig "imageHash", outputs: ["string"]

#  function **isApprovedForAll**(address owner, address operator) ⇒ (bool _) _readonly_
def isApprovedForAll(owner, operator)
  do_call("isApprovedForAll", owner, operator)
end
sig "isApprovedForAll", inputs: ["address","address"], outputs: ["bool"]

#  function **isSaleOn**() ⇒ (bool _) _readonly_
def isSaleOn()
  do_call("isSaleOn")
end
sig "isSaleOn", outputs: ["bool"]

#  function **name**() ⇒ (string _) _readonly_
def name()
  do_call("name")
end
sig "name", outputs: ["string"]

#  function **numTotalPhunks**() ⇒ (uint256 _) _readonly_
def numTotalPhunks()
  do_call("numTotalPhunks")
end
sig "numTotalPhunks", outputs: ["uint256"]

#  function **owner**() ⇒ (address _) _readonly_
def owner()
  do_call("owner")
end
sig "owner", outputs: ["address"]

#  function **ownerOf**(uint256 tokenId) ⇒ (address _) _readonly_
def ownerOf(tokenId)
  do_call("ownerOf", tokenId)
end
sig "ownerOf", inputs: ["uint256"], outputs: ["address"]

#  function **saleHasBeenStarted**() ⇒ (bool _) _readonly_
def saleHasBeenStarted()
  do_call("saleHasBeenStarted")
end
sig "saleHasBeenStarted", outputs: ["bool"]

#  function **supportsInterface**(bytes4 interfaceId) ⇒ (bool _) _readonly_
def supportsInterface(interfaceId)
  do_call("supportsInterface", interfaceId)
end
sig "supportsInterface", inputs: ["bytes4"], outputs: ["bool"]

#  function **symbol**() ⇒ (string _) _readonly_
def symbol()
  do_call("symbol")
end
sig "symbol", outputs: ["string"]

#  function **tokenByIndex**(uint256 index) ⇒ (uint256 _) _readonly_
def tokenByIndex(index)
  do_call("tokenByIndex", index)
end
sig "tokenByIndex", inputs: ["uint256"], outputs: ["uint256"]

#  function **tokenOfOwnerByIndex**(address owner, uint256 index) ⇒ (uint256 _) _readonly_
def tokenOfOwnerByIndex(owner, index)
  do_call("tokenOfOwnerByIndex", owner, index)
end
sig "tokenOfOwnerByIndex", inputs: ["address","uint256"], outputs: ["uint256"]

#  function **tokenURI**(uint256 _tokenId) ⇒ (string _) _readonly_
def tokenURI(_tokenId)
  do_call("tokenURI", _tokenId)
end
sig "tokenURI", inputs: ["uint256"], outputs: ["string"]

#  function **totalSupply**() ⇒ (uint256 _) _readonly_
def totalSupply()
  do_call("totalSupply")
end
sig "totalSupply", outputs: ["uint256"]

end   ## class PhunksV2

