#########################
# PunkBlocks contract / (blockchain) services / function calls
#  auto-generated via abigen (see https://rubygems.org/gems/abigen) on 2023-01-12 17:17:30 UTC
#  - 8 query functions(s)

#  
#  - Author: tycoon.eth, thanks to @geraldb & @samwilsn on Github for inspiration!
#  - Version: v0.0.2
#  - Pragma: solidity ^0.8.17
#  
#  
#  ```
#   ███████████                        █████
#  ░░███░░░░░███                      ░░███
#   ░███    ░███ █████ ████ ████████   ░███ █████
#   ░██████████ ░░███ ░███ ░░███░░███  ░███░░███
#   ░███░░░░░░   ░███ ░███  ░███ ░███  ░██████░
#   ░███         ░███ ░███  ░███ ░███  ░███░░███
#   █████        ░░████████ ████ █████ ████ █████
#  ░░░░░          ░░░░░░░░ ░░░░ ░░░░░ ░░░░ ░░░░░
#  
#  
#  
#   ███████████  ████                    █████
#  ░░███░░░░░███░░███                   ░░███
#   ░███    ░███ ░███   ██████   ██████  ░███ █████  █████
#   ░██████████  ░███  ███░░███ ███░░███ ░███░░███  ███░░
#   ░███░░░░░███ ░███ ░███ ░███░███ ░░░  ░██████░  ░░█████
#   ░███    ░███ ░███ ░███ ░███░███  ███ ░███░░███  ░░░░███
#   ███████████  █████░░██████ ░░██████  ████ █████ ██████
#  ░░░░░░░░░░░  ░░░░░  ░░░░░░   ░░░░░░  ░░░░ ░░░░░ ░░░░░░
#  ```
#  
#  A Registry of 24x24 png images
#  
#  This contract:
#  
#  1. Stores all the classic traits of the CryptoPunks in
#  individual png files, 100% on-chain. These are then used as
#  blocks to construct CryptoPunk images. Outputted as SVGs.
#  
#  2. Any of the 10,000 "classic" CryptoPunks can be generated
#  by supplying desired arguments to a function, such as
#  the id of a punk, or a list of the traits.
#  
#  3. An unlimited number of new punk images can be generated from
#  the existing classic set of traits, or even from new traits!
#  
#  4. New traits (blocks) can be added to the contract by
#  registering them with the `registerBlock` function.
#  
#  Further documentation:
#  https://github.com/0xTycoon/punk-blocks
#  
#  
#  
#  **Data Structures**
#  
#  Layer is in the order of rendering
#  
#  ```
#      enum Layer {
#          Base,      // 0 Base is the face. Determines if m or f version will be used to render the remaining layers
#          Cheeks,    // 1 (Rosy Cheeks)
#          Blemish,   // 2 (Mole, Spots)
#          Hair,      // 3 (Purple Hair, Shaved Head, Pigtails, ...)
#          Beard,     // 4 (Big Beard, Front Beard, Goat, ...)
#          Eyes,      // 5 (Clown Eyes Green, Green Eye Shadow, ...)
#          Eyewear,   // 6 (VR, 3D Glass, Eye Mask, Regular Shades, Welding Glasses, ...)
#          Nose,      // 7 (Clown Nose)
#          Mouth,     // 8 (Hot Lipstick, Smile, Buck Teeth, ...)
#          MouthProp, // 9 (Medical Mask, Cigarette, ...)
#          Earring,   // 10 (Earring)
#          Headgear,  // 11 (Beanie, Fedora, Hoodie, Police Cap, Tiara, Headband, ...)
#          Neck       // 12 (Choker, Silver Chain, Gold Chain)
#      }
#  ```
#  
#  ```
#      struct Block {
#          Layer layer;     // 13 possible layers
#          bytes dataMale;  // male version of this attribute
#          bytes dataFemale;// female version of this attribute
#      }
#  ```
#  
#  
#  **Events**
#  
#  ```
#  event NewBlock(address, uint256, string)
#  ```
#  
#  


class  PunkBlocks <  Ethlite::Contract

  address "0x58e90596c2065befd3060767736c829c18f3474c"

#  storage - mapping(bytes32 => Block) public blocks
#
#  
#  stores punk attributes as a png
#  
#  
sig "blocks", inputs: ["bytes32"], outputs: ["uint8","bytes","bytes"]
def blocks(arg0)
  do_call("blocks", arg0)
end

#  function getBlocks
#
#  
#  ```
#  getBlocks returns a sequential list of blocks in a single call
#      @param _fromID is which id to begin from
#      @param _count how many items to retrieve.
#      @return Block[] list of blocks, uint256 next id
#  ```
#  
sig "getBlocks", inputs: ["uint256","uint256"], outputs: ["(uint8,bytes,bytes)[]","uint256"]
def getBlocks(_fromID, _count)
  do_call("getBlocks", _fromID, _count)
end

#  storage - mapping(uint256 => bytes32) public index
#
#  
#  index of each block by its sequence
#  
#  
#  
sig "index", inputs: ["uint256"], outputs: ["bytes32"]
def index(arg0)
  do_call("index", arg0)
end

#  storage - uint256 public nextId
#
#  
#  next id to use when adding a block
#  
sig "nextId", outputs: ["uint256"]
def nextId()
  do_call("nextId")
end

#  function svgFromIDs
#
#  
#  ```
#  svgFromIDs returns the svg data as a string
#         e.g. [9,55,99]
#         One of the elements must be must be a layer 0 block.
#         This element decides what version of image to use for the higher layers
#         (dataMale or dataFemale)
#       @param _ids uint256 ids of an attribute, by it's index of creation
#  ```
#  
sig "svgFromIDs", inputs: ["uint256[]"], outputs: ["string"]
def svgFromIDs(_ids)
  do_call("svgFromIDs", _ids)
end

#  function svgFromKeys
#
#  
#  ```
#  svgFromKeys returns the svg data as a string
#  @param _attributeKeys a list of attribute names that have been hashed,
#          eg keccak256("Male 1"), keccak256("Goat")
#          must have at least 1 layer 0 attribute (eg. keccak256("Male 1")) which
#          decides what version of image to use for the higher layers
#          (dataMale or dataFemale)
#          e.g. ["0x9039da071f773e85254cbd0f99efa70230c4c11d63fce84323db9eca8e8ef283",
#          "0xd5de5c20969a9e22f93842ca4d65bac0c0387225cee45a944a14f03f9221fd4a"]
#  ```
#  
sig "svgFromKeys", inputs: ["bytes32[]"], outputs: ["string"]
def svgFromKeys(_attributeKeys)
  do_call("svgFromKeys", _attributeKeys)
end

#  function svgFromNames
#
#  
#  ```
#  svgFromNames returns the svg data as a string
#  @param _attributeNames a list of attribute names, eg "Male 1", "Goat"
#     must have at least 1 layer 0 attribute (eg. Male, Female, Alien, Ape, Zombie)
#     e.g. ["Male 1","Goat"]
#     Where "Male 1" is a layer 0 attribute, that decides what version of
#     image to use for the higher
#    layers (dataMale or dataFemale)
#  ```
#  
#  
sig "svgFromNames", inputs: ["string[]"], outputs: ["string"]
def svgFromNames(_attributeNames)
  do_call("svgFromNames", _attributeNames)
end

#  function svgFromPunkID
#
#  
#  ```
#  svgFromPunkID returns the svg data as a string given a punk id
#      @param _tokenID uint256 IDs a punk id, 0-9999
#  ```
#  
sig "svgFromPunkID", inputs: ["uint256"], outputs: ["string"]
def svgFromPunkID(_tokenID)
  do_call("svgFromPunkID", _tokenID)
end

end   ## class PunkBlocks

