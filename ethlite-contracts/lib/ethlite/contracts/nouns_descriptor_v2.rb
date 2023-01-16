# NounsDescriptorV2 contract / (blockchain) services / function calls
#
#  auto-generated via abigen (see https://rubygems.org/gems/abigen) on 2023-01-16 16:17:16 UTC
#  - 22 query functions(s)
#  - 0 helper functions(s)


class  NounsDescriptorV2 <  Ethlite::Contract

  address "0x6229c811d04501523c6058bfaac29c91bb586268"

#  function **accessories**(uint256 index) ⇒ (bytes _) _readonly_
def accessories(index)
  do_call("accessories", index)
end
sig "accessories", inputs: ["uint256"], outputs: ["bytes"]

#  function **accessoryCount**() ⇒ (uint256 _) _readonly_
def accessoryCount()
  do_call("accessoryCount")
end
sig "accessoryCount", outputs: ["uint256"]

#  function **arePartsLocked**() ⇒ (bool _) _readonly_
def arePartsLocked()
  do_call("arePartsLocked")
end
sig "arePartsLocked", outputs: ["bool"]

#  function **art**() ⇒ (contract INounsArt _) _readonly_
def art()
  do_call("art")
end
sig "art", outputs: ["address"]

#  function **backgroundCount**() ⇒ (uint256 _) _readonly_
def backgroundCount()
  do_call("backgroundCount")
end
sig "backgroundCount", outputs: ["uint256"]

#  function **backgrounds**(uint256 index) ⇒ (string _) _readonly_
def backgrounds(index)
  do_call("backgrounds", index)
end
sig "backgrounds", inputs: ["uint256"], outputs: ["string"]

#  function **baseURI**() ⇒ (string _) _readonly_
def baseURI()
  do_call("baseURI")
end
sig "baseURI", outputs: ["string"]

#  function **bodies**(uint256 index) ⇒ (bytes _) _readonly_
def bodies(index)
  do_call("bodies", index)
end
sig "bodies", inputs: ["uint256"], outputs: ["bytes"]

#  function **bodyCount**() ⇒ (uint256 _) _readonly_
def bodyCount()
  do_call("bodyCount")
end
sig "bodyCount", outputs: ["uint256"]

#  function **dataURI**(uint256 tokenId, struct INounsSeeder.Seed seed) ⇒ (string _) _readonly_
def dataURI(tokenId, seed)
  do_call("dataURI", tokenId, seed)
end
sig "dataURI", inputs: ["uint256","(uint48,uint48,uint48,uint48,uint48)"], outputs: ["string"]

#  function **generateSVGImage**(struct INounsSeeder.Seed seed) ⇒ (string _) _readonly_
def generateSVGImage(seed)
  do_call("generateSVGImage", seed)
end
sig "generateSVGImage", inputs: ["(uint48,uint48,uint48,uint48,uint48)"], outputs: ["string"]

#  function **genericDataURI**(string name, string description, struct INounsSeeder.Seed seed) ⇒ (string _) _readonly_
def genericDataURI(name, description, seed)
  do_call("genericDataURI", name, description, seed)
end
sig "genericDataURI", inputs: ["string","string","(uint48,uint48,uint48,uint48,uint48)"], outputs: ["string"]

#  function **getPartsForSeed**(struct INounsSeeder.Seed seed) ⇒ (struct ISVGRenderer.Part[] _) _readonly_
def getPartsForSeed(seed)
  do_call("getPartsForSeed", seed)
end
sig "getPartsForSeed", inputs: ["(uint48,uint48,uint48,uint48,uint48)"], outputs: ["(bytes,bytes)[]"]

#  function **glasses**(uint256 index) ⇒ (bytes _) _readonly_
def glasses(index)
  do_call("glasses", index)
end
sig "glasses", inputs: ["uint256"], outputs: ["bytes"]

#  function **glassesCount**() ⇒ (uint256 _) _readonly_
def glassesCount()
  do_call("glassesCount")
end
sig "glassesCount", outputs: ["uint256"]

#  function **headCount**() ⇒ (uint256 _) _readonly_
def headCount()
  do_call("headCount")
end
sig "headCount", outputs: ["uint256"]

#  function **heads**(uint256 index) ⇒ (bytes _) _readonly_
def heads(index)
  do_call("heads", index)
end
sig "heads", inputs: ["uint256"], outputs: ["bytes"]

#  function **isDataURIEnabled**() ⇒ (bool _) _readonly_
def isDataURIEnabled()
  do_call("isDataURIEnabled")
end
sig "isDataURIEnabled", outputs: ["bool"]

#  function **owner**() ⇒ (address _) _readonly_
def owner()
  do_call("owner")
end
sig "owner", outputs: ["address"]

#  function **palettes**(uint8 index) ⇒ (bytes _) _readonly_
def palettes(index)
  do_call("palettes", index)
end
sig "palettes", inputs: ["uint8"], outputs: ["bytes"]

#  function **renderer**() ⇒ (contract ISVGRenderer _) _readonly_
def renderer()
  do_call("renderer")
end
sig "renderer", outputs: ["address"]

#  function **tokenURI**(uint256 tokenId, struct INounsSeeder.Seed seed) ⇒ (string _) _readonly_
def tokenURI(tokenId, seed)
  do_call("tokenURI", tokenId, seed)
end
sig "tokenURI", inputs: ["uint256","(uint48,uint48,uint48,uint48,uint48)"], outputs: ["string"]

end   ## class NounsDescriptorV2

