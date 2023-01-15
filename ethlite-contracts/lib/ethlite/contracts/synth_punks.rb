# SynthPunks contract / (blockchain) services / function calls
#
#  auto-generated via abigen (see https://rubygems.org/gems/abigen) on 2023-01-15 16:36:48 UTC
#  - 20 query functions(s)
#  - 8 helper functions(s)


class  SynthPunks <  Ethlite::Contract

  address "0xaf9ce4b327a3b690abea6f78eccbfefffbea9fdf"

#  function **_getAttributes**(address _address) ⇒ (uint256[] _) _readonly_
def _getAttributes(_address)
  do_call("_getAttributes", _address)
end
sig "_getAttributes", inputs: ["address"], outputs: ["uint256[]"]

#  function **_tokenURI**(address _address) ⇒ (string _) _readonly_
def _tokenURI(_address)
  do_call("_tokenURI", _address)
end
sig "_tokenURI", inputs: ["address"], outputs: ["string"]

#  function **assets**() ⇒ (contract ISyntheticPunksAssets _) _readonly_
def assets()
  do_call("assets")
end
sig "assets", outputs: ["address"]

#  function **balanceOf**(address _) ⇒ (uint256 _) _readonly_
def balanceOf(arg0)
  do_call("balanceOf", arg0)
end
sig "balanceOf", inputs: ["address"], outputs: ["uint256"]

#  function **claimMessage**() ⇒ (string _) _readonly_
def claimMessage()
  do_call("claimMessage")
end
sig "claimMessage", outputs: ["string"]

#  function **claimPrice**() ⇒ (uint256 _) _readonly_
def claimPrice()
  do_call("claimPrice")
end
sig "claimPrice", outputs: ["uint256"]

#  function **claimed**(address _) ⇒ (bool _) _readonly_
def claimed(arg0)
  do_call("claimed", arg0)
end
sig "claimed", inputs: ["address"], outputs: ["bool"]

#  function **generatePunkSVG**(uint256[] layers) ⇒ (string _) _readonly_
def generatePunkSVG(layers)
  do_call("generatePunkSVG", layers)
end
sig "generatePunkSVG", inputs: ["uint256[]"], outputs: ["string"]

#  function **getApproved**(uint256 _) ⇒ (address _) _readonly_
def getApproved(arg0)
  do_call("getApproved", arg0)
end
sig "getApproved", inputs: ["uint256"], outputs: ["address"]

#  function **getAttribute**(uint256 id, uint256 _attributeId) ⇒ (uint256 _) _readonly_
def getAttribute(id, _attributeId)
  do_call("getAttribute", id, _attributeId)
end
sig "getAttribute", inputs: ["uint256","uint256"], outputs: ["uint256"]

#  function **getAttributeCategories**(uint256 id) ⇒ (uint256[] _) _readonly_
def getAttributeCategories(id)
  do_call("getAttributeCategories", id)
end
sig "getAttributeCategories", inputs: ["uint256"], outputs: ["uint256[]"]

#  function **getAttributes**(uint256 id) ⇒ (uint256[] _) _readonly_
def getAttributes(id)
  do_call("getAttributes", id)
end
sig "getAttributes", inputs: ["uint256"], outputs: ["uint256[]"]

#  function **getGender**(uint256 id) ⇒ (enum SyntheticPunks.Gender _) _readonly_
def getGender(id)
  do_call("getGender", id)
end
sig "getGender", inputs: ["uint256"], outputs: ["uint8"]

#  function **isApprovedForAll**(address _, address _) ⇒ (bool _) _readonly_
def isApprovedForAll(arg0, arg1)
  do_call("isApprovedForAll", arg0, arg1)
end
sig "isApprovedForAll", inputs: ["address","address"], outputs: ["bool"]

#  function **name**() ⇒ (string _) _readonly_
def name()
  do_call("name")
end
sig "name", outputs: ["string"]

#  function **ownerOf**(uint256 _) ⇒ (address _) _readonly_
def ownerOf(arg0)
  do_call("ownerOf", arg0)
end
sig "ownerOf", inputs: ["uint256"], outputs: ["address"]

#  function **randomUint**(uint256 seed, uint256 offset) ⇒ (uint256 _) _readonly_
def randomUint(seed, offset)
  do_call("randomUint", seed, offset)
end
sig "randomUint", inputs: ["uint256","uint256"], outputs: ["uint256"]

#  function **symbol**() ⇒ (string _) _readonly_
def symbol()
  do_call("symbol")
end
sig "symbol", outputs: ["string"]

#  function **tokenURI**(uint256 id) ⇒ (string _) _readonly_
def tokenURI(id)
  do_call("tokenURI", id)
end
sig "tokenURI", inputs: ["uint256"], outputs: ["string"]

#  function **withdrawAddress**() ⇒ (address _) _readonly_
def withdrawAddress()
  do_call("withdrawAddress")
end
sig "withdrawAddress", outputs: ["address"]


#  function **getAddress**(uint256 id) ⇒ (address _) _readonly_
def getAddress(id)
  do_call("getAddress", id)
end
sig "getAddress", inputs: ["uint256"], outputs: ["address"]

#  function **getEthSignedMessageHash**(bytes32 _messageHash) ⇒ (bytes32 _) _readonly_
def getEthSignedMessageHash(_messageHash)
  do_call("getEthSignedMessageHash", _messageHash)
end
sig "getEthSignedMessageHash", inputs: ["bytes32"], outputs: ["bytes32"]

#  function **getMessageHash**(string _message) ⇒ (bytes32 _) _readonly_
def getMessageHash(_message)
  do_call("getMessageHash", _message)
end
sig "getMessageHash", inputs: ["string"], outputs: ["bytes32"]

#  function **getTokenID**(address _address) ⇒ (uint256 _) _readonly_
def getTokenID(_address)
  do_call("getTokenID", _address)
end
sig "getTokenID", inputs: ["address"], outputs: ["uint256"]

#  function **recoverSigner**(bytes32 _ethSignedMessageHash, bytes _signature) ⇒ (address _) _readonly_
def recoverSigner(_ethSignedMessageHash, _signature)
  do_call("recoverSigner", _ethSignedMessageHash, _signature)
end
sig "recoverSigner", inputs: ["bytes32","bytes"], outputs: ["address"]

#  function **splitSignature**(bytes sig) ⇒ (bytes32 r, bytes32 s, uint8 v) _readonly_
def splitSignature(sig)
  do_call("splitSignature", sig)
end
sig "splitSignature", inputs: ["bytes"], outputs: ["bytes32","bytes32","uint8"]

#  function **supportsInterface**(bytes4 interfaceId) ⇒ (bool _) _readonly_
def supportsInterface(interfaceId)
  do_call("supportsInterface", interfaceId)
end
sig "supportsInterface", inputs: ["bytes4"], outputs: ["bool"]

#  function **verify**(address _signer, string _message, bytes signature) ⇒ (bool _) _readonly_
def verify(_signer, _message, signature)
  do_call("verify", _signer, _message, signature)
end
sig "verify", inputs: ["address","string","bytes"], outputs: ["bool"]

end   ## class SynthPunks

