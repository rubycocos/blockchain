# MadCamels contract / (blockchain) services / function calls
#
#  auto-generated via abigen (see https://rubygems.org/gems/abigen) on 2023-01-15 16:36:56 UTC
#  - 31 query functions(s)
#  - 0 helper functions(s)


class  MadCamels <  Ethlite::Contract

  address "0xad8474ba5a7f6abc52708f171f57fefc5cdc8c1c"

#  function **allowListPrice**() ⇒ (uint256 _) _readonly_
def allowListPrice()
  do_call("allowListPrice")
end
sig "allowListPrice", outputs: ["uint256"]

#  function **balanceOf**(address owner) ⇒ (uint256 _) _readonly_
def balanceOf(owner)
  do_call("balanceOf", owner)
end
sig "balanceOf", inputs: ["address"], outputs: ["uint256"]

#  function **baseURI**() ⇒ (string _) _readonly_
def baseURI()
  do_call("baseURI")
end
sig "baseURI", outputs: ["string"]

#  function **contractData**() ⇒ (string name, string description, string image, string banner, string website, uint256 royalties, string royaltiesRecipient) _readonly_
def contractData()
  do_call("contractData")
end
sig "contractData", outputs: ["string","string","string","string","string","uint256","string"]

#  function **contractURI**() ⇒ (string _) _readonly_
def contractURI()
  do_call("contractURI")
end
sig "contractURI", outputs: ["string"]

#  function **getApproved**(uint256 tokenId) ⇒ (address _) _readonly_
def getApproved(tokenId)
  do_call("getApproved", tokenId)
end
sig "getApproved", inputs: ["uint256"], outputs: ["address"]

#  function **getLinkedTraits**(uint256 _layerIndex, uint256 _traitIndex) ⇒ (uint256[] _) _readonly_
def getLinkedTraits(_layerIndex, _traitIndex)
  do_call("getLinkedTraits", _layerIndex, _traitIndex)
end
sig "getLinkedTraits", inputs: ["uint256","uint256"], outputs: ["uint256[]"]

#  function **hashToMetadata**(string _hash) ⇒ (string _) _readonly_
def hashToMetadata(_hash)
  do_call("hashToMetadata", _hash)
end
sig "hashToMetadata", inputs: ["string"], outputs: ["string"]

#  function **hashToSVG**(string _hash) ⇒ (string _) _readonly_
def hashToSVG(_hash)
  do_call("hashToSVG", _hash)
end
sig "hashToSVG", inputs: ["string"], outputs: ["string"]

#  function **isAllowListActive**() ⇒ (bool _) _readonly_
def isAllowListActive()
  do_call("isAllowListActive")
end
sig "isAllowListActive", outputs: ["bool"]

#  function **isApprovedForAll**(address owner, address operator) ⇒ (bool _) _readonly_
def isApprovedForAll(owner, operator)
  do_call("isApprovedForAll", owner, operator)
end
sig "isApprovedForAll", inputs: ["address","address"], outputs: ["bool"]

#  function **isContractSealed**() ⇒ (bool _) _readonly_
def isContractSealed()
  do_call("isContractSealed")
end
sig "isContractSealed", outputs: ["bool"]

#  function **isMintActive**() ⇒ (bool _) _readonly_
def isMintActive()
  do_call("isMintActive")
end
sig "isMintActive", outputs: ["bool"]

#  function **isPublicMintActive**() ⇒ (bool _) _readonly_
def isPublicMintActive()
  do_call("isPublicMintActive")
end
sig "isPublicMintActive", outputs: ["bool"]

#  function **maxPerAddress**() ⇒ (uint256 _) _readonly_
def maxPerAddress()
  do_call("maxPerAddress")
end
sig "maxPerAddress", outputs: ["uint256"]

#  function **maxPerAllowList**() ⇒ (uint256 _) _readonly_
def maxPerAllowList()
  do_call("maxPerAllowList")
end
sig "maxPerAllowList", outputs: ["uint256"]

#  function **maxSupply**() ⇒ (uint256 _) _readonly_
def maxSupply()
  do_call("maxSupply")
end
sig "maxSupply", outputs: ["uint256"]

#  function **name**() ⇒ (string _) _readonly_
def name()
  do_call("name")
end
sig "name", outputs: ["string"]

#  function **onAllowList**(address addr, bytes32[] merkleProof) ⇒ (bool _) _readonly_
def onAllowList(addr, merkleProof)
  do_call("onAllowList", addr, merkleProof)
end
sig "onAllowList", inputs: ["address","bytes32[]"], outputs: ["bool"]

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

#  function **publicMintPrice**() ⇒ (uint256 _) _readonly_
def publicMintPrice()
  do_call("publicMintPrice")
end
sig "publicMintPrice", outputs: ["uint256"]

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

#  function **tokenIdToHash**(uint256 _tokenId) ⇒ (string _) _readonly_
def tokenIdToHash(_tokenId)
  do_call("tokenIdToHash", _tokenId)
end
sig "tokenIdToHash", inputs: ["uint256"], outputs: ["string"]

#  function **tokenIdToSVG**(uint256 _tokenId) ⇒ (string _) _readonly_
def tokenIdToSVG(_tokenId)
  do_call("tokenIdToSVG", _tokenId)
end
sig "tokenIdToSVG", inputs: ["uint256"], outputs: ["string"]

#  function **tokenURI**(uint256 _tokenId) ⇒ (string _) _readonly_
def tokenURI(_tokenId)
  do_call("tokenURI", _tokenId)
end
sig "tokenURI", inputs: ["uint256"], outputs: ["string"]

#  function **tokensAreDuplicates**(uint256 tokenIdA, uint256 tokenIdB) ⇒ (bool _) _readonly_
def tokensAreDuplicates(tokenIdA, tokenIdB)
  do_call("tokensAreDuplicates", tokenIdA, tokenIdB)
end
sig "tokensAreDuplicates", inputs: ["uint256","uint256"], outputs: ["bool"]

#  function **totalSupply**() ⇒ (uint256 _) _readonly_
def totalSupply()
  do_call("totalSupply")
end
sig "totalSupply", outputs: ["uint256"]

#  function **traitData**(uint256 _layerIndex, uint256 _traitIndex) ⇒ (string _) _readonly_
def traitData(_layerIndex, _traitIndex)
  do_call("traitData", _layerIndex, _traitIndex)
end
sig "traitData", inputs: ["uint256","uint256"], outputs: ["string"]

#  function **traitDetails**(uint256 _layerIndex, uint256 _traitIndex) ⇒ (struct Indelible.Trait _) _readonly_
def traitDetails(_layerIndex, _traitIndex)
  do_call("traitDetails", _layerIndex, _traitIndex)
end
sig "traitDetails", inputs: ["uint256","uint256"], outputs: ["(string,string)"]

end   ## class MadCamels

