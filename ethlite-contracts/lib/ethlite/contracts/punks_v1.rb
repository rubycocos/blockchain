# PunksV1 contract / (blockchain) services / function calls
#
#  auto-generated via abigen (see https://rubygems.org/gems/abigen) on 2023-01-15 16:36:57 UTC
#  - 14 query functions(s)
#  - 0 helper functions(s)
#
#
#  - Pragma:  solidity ^0.4.8
#
#
#  **Data Structures**
#
#
#          struct Offer {
#              bool isForSale;
#              uint punkIndex;
#              address seller;
#              uint minValue;          // in ether
#              address onlySellTo;     // specify to sell only to a specific person
#          }
#
#  **Events**
#
#          event Assign(address indexed to, uint256 punkIndex)
#          event Transfer(address indexed from, address indexed to, uint256 value)
#          event PunkTransfer(address indexed from, address indexed to, uint256 punkIndex)
#          event PunkOffered(uint indexed punkIndex, uint minValue, address indexed toAddress)
#          event PunkBought(uint indexed punkIndex, uint value, address indexed fromAddress, address indexed toAddress)
#          event PunkNoLongerForSale(uint indexed punkIndex)


class  PunksV1 <  Ethlite::Contract

  address "0x6ba6f2207e343923ba692e5cae646fb0f566db8d"

#  storage - string public name
#
def name()
  do_call("name")
end
sig "name", outputs: ["string"]

#  storage - mapping (uint => Offer) public punksOfferedForSale
#
#  A record of punks that are offered for sale at a specific minimum value, and perhaps to a specific person
def punksOfferedForSale(arg0)
  do_call("punksOfferedForSale", arg0)
end
sig "punksOfferedForSale", inputs: ["uint256"], outputs: ["bool","uint256","address","uint256","address"]

#  storage -   uint256 public totalSupply
#
def totalSupply()
  do_call("totalSupply")
end
sig "totalSupply", outputs: ["uint256"]

#  storage -    uint8 public decimals
#
def decimals()
  do_call("decimals")
end
sig "decimals", outputs: ["uint8"]

#  storage - string public imageHash
#
#  You can use this hash to verify the image file containing all the punks
def imageHash()
  do_call("imageHash")
end
sig "imageHash", outputs: ["string"]

#  storage -    uint public nextPunkIndexToAssign
#
def nextPunkIndexToAssign()
  do_call("nextPunkIndexToAssign")
end
sig "nextPunkIndexToAssign", outputs: ["uint256"]

#  storage -   mapping (uint => address) public punkIndexToAddress
#
def punkIndexToAddress(arg0)
  do_call("punkIndexToAddress", arg0)
end
sig "punkIndexToAddress", inputs: ["uint256"], outputs: ["address"]

#  storage - string public standard
#
def standard()
  do_call("standard")
end
sig "standard", outputs: ["string"]

#  storage -  mapping (address => uint256) public balanceOf
#
#  This creates an array with all balances
def balanceOf(arg0)
  do_call("balanceOf", arg0)
end
sig "balanceOf", inputs: ["address"], outputs: ["uint256"]

#  storage -    string public symbol
#
def symbol()
  do_call("symbol")
end
sig "symbol", outputs: ["string"]

#  storage -   uint public numberOfPunksToReserve
#
def numberOfPunksToReserve()
  do_call("numberOfPunksToReserve")
end
sig "numberOfPunksToReserve", outputs: ["uint256"]

#  storage -   uint public numberOfPunksReserved
#
def numberOfPunksReserved()
  do_call("numberOfPunksReserved")
end
sig "numberOfPunksReserved", outputs: ["uint256"]

#  storage -   uint public punksRemainingToAssign
#
def punksRemainingToAssign()
  do_call("punksRemainingToAssign")
end
sig "punksRemainingToAssign", outputs: ["uint256"]

#  storage - mapping (address => uint) public pendingWithdrawals
#
def pendingWithdrawals(arg0)
  do_call("pendingWithdrawals", arg0)
end
sig "pendingWithdrawals", inputs: ["address"], outputs: ["uint256"]

end   ## class PunksV1

