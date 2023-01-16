# NounsDescriptor contract / (blockchain) services / function calls
#
#  auto-generated via abigen (see https://rubygems.org/gems/abigen) on 2023-01-16 16:17:10 UTC
#  - 19 query functions(s)
#  - 0 helper functions(s)


class  NounsDescriptor <  Ethlite::Contract

  address "0x0cfdb3ba1694c2bb2cfacb0339ad7b1ae5932b63"

#  function **accessories**(uint256 _) ⇒ (bytes _) _readonly_
def accessories(arg0)
  do_call("accessories", arg0)
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

#  function **backgroundCount**() ⇒ (uint256 _) _readonly_
def backgroundCount()
  do_call("backgroundCount")
end
sig "backgroundCount", outputs: ["uint256"]

#  function **backgrounds**(uint256 _) ⇒ (string _) _readonly_
def backgrounds(arg0)
  do_call("backgrounds", arg0)
end
sig "backgrounds", inputs: ["uint256"], outputs: ["string"]

#  function **baseURI**() ⇒ (string _) _readonly_
def baseURI()
  do_call("baseURI")
end
sig "baseURI", outputs: ["string"]

#  function **bodies**(uint256 _) ⇒ (bytes _) _readonly_
def bodies(arg0)
  do_call("bodies", arg0)
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

#  function **glasses**(uint256 _) ⇒ (bytes _) _readonly_
def glasses(arg0)
  do_call("glasses", arg0)
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

#  function **heads**(uint256 _) ⇒ (bytes _) _readonly_
def heads(arg0)
  do_call("heads", arg0)
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

#  function **palettes**(uint8 _, uint256 _) ⇒ (string _) _readonly_
def palettes(arg0, arg1)
  do_call("palettes", arg0, arg1)
end
sig "palettes", inputs: ["uint8","uint256"], outputs: ["string"]

#  function **tokenURI**(uint256 tokenId, struct INounsSeeder.Seed seed) ⇒ (string _) _readonly_
def tokenURI(tokenId, seed)
  do_call("tokenURI", tokenId, seed)
end
sig "tokenURI", inputs: ["uint256","(uint48,uint48,uint48,uint48,uint48)"], outputs: ["string"]

end   ## class NounsDescriptor

