#########################
# PunkBlocks contract / (blockchain) services / function calls
#    auto-generated via abigen (see https://rubygems.org/gems/abigen) on 2023-01-09 17:48:57 UTC
#    - 8 query functions(s)

class  PunkBlocks <  Ethlite::Contract

  address "0x58e90596c2065befd3060767736c829c18f3474c"

#  function **blocks**(bytes32 _) ⇒ (enum PunkBlocks.Layer layer, bytes dataMale, bytes dataFemale) _readonly_
sig "blocks", inputs: ["bytes32"], outputs: ["uint8","bytes","bytes"]
def blocks(arg0)
  do_call("blocks", arg0)
end

#  function **getBlocks**(uint256 _fromID, uint256 _count) ⇒ (struct PunkBlocks.Block[] _, uint256 _) _readonly_
sig "getBlocks", inputs: ["uint256","uint256"], outputs: ["(uint8,bytes,bytes)[]","uint256"]
def getBlocks(_fromID, _count)
  do_call("getBlocks", _fromID, _count)
end

#  function **index**(uint256 _) ⇒ (bytes32 _) _readonly_
sig "index", inputs: ["uint256"], outputs: ["bytes32"]
def index(arg0)
  do_call("index", arg0)
end

#  function **nextId**() ⇒ (uint256 _) _readonly_
sig "nextId", outputs: ["uint256"]
def nextId()
  do_call("nextId")
end

#  function **svgFromIDs**(uint256[] _ids) ⇒ (string _) _readonly_
sig "svgFromIDs", inputs: ["uint256[]"], outputs: ["string"]
def svgFromIDs(_ids)
  do_call("svgFromIDs", _ids)
end

#  function **svgFromKeys**(bytes32[] _attributeKeys) ⇒ (string _) _readonly_
sig "svgFromKeys", inputs: ["bytes32[]"], outputs: ["string"]
def svgFromKeys(_attributeKeys)
  do_call("svgFromKeys", _attributeKeys)
end

#  function **svgFromNames**(string[] _attributeNames) ⇒ (string _) _readonly_
sig "svgFromNames", inputs: ["string[]"], outputs: ["string"]
def svgFromNames(_attributeNames)
  do_call("svgFromNames", _attributeNames)
end

#  function **svgFromPunkID**(uint256 _tokenID) ⇒ (string _) _readonly_
sig "svgFromPunkID", inputs: ["uint256"], outputs: ["string"]
def svgFromPunkID(_tokenID)
  do_call("svgFromPunkID", _tokenID)
end

end   ## class PunkBlocks

