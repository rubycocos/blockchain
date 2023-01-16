# SynthNouns contract / (blockchain) services / function calls
#
#  auto-generated via abigen (see https://rubygems.org/gems/abigen) on 2023-01-16 16:17:17 UTC
#  - 14 query functions(s)
#  - 1 helper functions(s)


class  SynthNouns <  Ethlite::Contract

  address "0x8761b55af5a703d5855f1865db8fe4dd18e94c53"

#  function **addressPreview**(address _address) ⇒ (string _) _readonly_
def addressPreview(_address)
  do_call("addressPreview", _address)
end
sig "addressPreview", inputs: ["address"], outputs: ["string"]

#  function **balanceOf**(address owner) ⇒ (uint256 _) _readonly_
def balanceOf(owner)
  do_call("balanceOf", owner)
end
sig "balanceOf", inputs: ["address"], outputs: ["uint256"]

#  function **claimed**(address _) ⇒ (bool _) _readonly_
def claimed(arg0)
  do_call("claimed", arg0)
end
sig "claimed", inputs: ["address"], outputs: ["bool"]

#  function **claimerOf**(uint256 _) ⇒ (address _) _readonly_
def claimerOf(arg0)
  do_call("claimerOf", arg0)
end
sig "claimerOf", inputs: ["uint256"], outputs: ["address"]

#  function **descriptor**() ⇒ (contract INounsDescriptor _) _readonly_
def descriptor()
  do_call("descriptor")
end
sig "descriptor", outputs: ["address"]

#  function **getApproved**(uint256 tokenId) ⇒ (address _) _readonly_
def getApproved(tokenId)
  do_call("getApproved", tokenId)
end
sig "getApproved", inputs: ["uint256"], outputs: ["address"]

#  function **isApprovedForAll**(address owner, address operator) ⇒ (bool _) _readonly_
def isApprovedForAll(owner, operator)
  do_call("isApprovedForAll", owner, operator)
end
sig "isApprovedForAll", inputs: ["address","address"], outputs: ["bool"]

#  function **name**() ⇒ (string _) _readonly_
def name()
  do_call("name")
end
sig "name", outputs: ["string"]

#  function **ownerOf**(uint256 tokenId) ⇒ (address _) _readonly_
def ownerOf(tokenId)
  do_call("ownerOf", tokenId)
end
sig "ownerOf", inputs: ["uint256"], outputs: ["address"]

#  function **reverseRecords**() ⇒ (contract IENSReverseRecords _) _readonly_
def reverseRecords()
  do_call("reverseRecords")
end
sig "reverseRecords", outputs: ["address"]

#  function **seeds**(uint256 _) ⇒ (uint48 background, uint48 body, uint48 accessory, uint48 head, uint48 glasses) _readonly_
def seeds(arg0)
  do_call("seeds", arg0)
end
sig "seeds", inputs: ["uint256"], outputs: ["uint48","uint48","uint48","uint48","uint48"]

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

#  function **tokenURI**(uint256 _tokenId) ⇒ (string _) _readonly_
def tokenURI(_tokenId)
  do_call("tokenURI", _tokenId)
end
sig "tokenURI", inputs: ["uint256"], outputs: ["string"]


#  function **getSeedInput**(address _address) ⇒ (uint256 _) _readonly_
def getSeedInput(_address)
  do_call("getSeedInput", _address)
end
sig "getSeedInput", inputs: ["address"], outputs: ["uint256"]

end   ## class SynthNouns

