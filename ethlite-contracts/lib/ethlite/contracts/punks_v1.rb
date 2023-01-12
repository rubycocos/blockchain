#########################
# PunksV1 contract / (blockchain) services / function calls
#  auto-generated via abigen (see https://rubygems.org/gems/abigen) on 2023-01-12 17:17:29 UTC
#  - 14 query functions(s)

#  - Pragma:  solidity ^0.4.8
#  
#  
#  **Data Structures**
#  
#  
#  ```
#      struct Offer {
#          bool isForSale;
#          uint punkIndex;
#          address seller;
#          uint minValue;          // in ether
#          address onlySellTo;     // specify to sell only to a specific person
#      }
#  ```
#  
#  **Events**
#  
#  ```
#      event Assign(address indexed to, uint256 punkIndex)
#      event Transfer(address indexed from, address indexed to, uint256 value)
#      event PunkTransfer(address indexed from, address indexed to, uint256 punkIndex)
#      event PunkOffered(uint indexed punkIndex, uint minValue, address indexed toAddress)
#      event PunkBought(uint indexed punkIndex, uint value, address indexed fromAddress, address indexed toAddress)
#      event PunkNoLongerForSale(uint indexed punkIndex)
#  ```
#  
#  
#  
#  


class  PunksV1 <  Ethlite::Contract

  address "0x6ba6f2207e343923ba692e5cae646fb0f566db8d"

#  storage - string public name
#
sig "name", outputs: ["string"]
def name()
  do_call("name")
end

#  storage - mapping (uint => Offer) public punksOfferedForSale
#
#  
#  A record of punks that are offered for sale at a specific minimum value, and perhaps to a specific person
#  
sig "punksOfferedForSale", inputs: ["uint256"], outputs: ["bool","uint256","address","uint256","address"]
def punksOfferedForSale(arg0)
  do_call("punksOfferedForSale", arg0)
end

#  storage -   uint256 public totalSupply
#
#  
sig "totalSupply", outputs: ["uint256"]
def totalSupply()
  do_call("totalSupply")
end

#  storage -    uint8 public decimals
#
sig "decimals", outputs: ["uint8"]
def decimals()
  do_call("decimals")
end

#  storage - string public imageHash
#
#  
#  You can use this hash to verify the image file containing all the punks
#  
sig "imageHash", outputs: ["string"]
def imageHash()
  do_call("imageHash")
end

#  storage -    uint public nextPunkIndexToAssign
#
#  
sig "nextPunkIndexToAssign", outputs: ["uint256"]
def nextPunkIndexToAssign()
  do_call("nextPunkIndexToAssign")
end

#  storage -   mapping (uint => address) public punkIndexToAddress
#
#  
#  
sig "punkIndexToAddress", inputs: ["uint256"], outputs: ["address"]
def punkIndexToAddress(arg0)
  do_call("punkIndexToAddress", arg0)
end

#  storage - string public standard
#
#  
sig "standard", outputs: ["string"]
def standard()
  do_call("standard")
end

#  storage -  mapping (address => uint256) public balanceOf
#
#  This creates an array with all balances
#  
#  
sig "balanceOf", inputs: ["address"], outputs: ["uint256"]
def balanceOf(arg0)
  do_call("balanceOf", arg0)
end

#  storage -    string public symbol
#
sig "symbol", outputs: ["string"]
def symbol()
  do_call("symbol")
end

#  storage -   uint public numberOfPunksToReserve
#
sig "numberOfPunksToReserve", outputs: ["uint256"]
def numberOfPunksToReserve()
  do_call("numberOfPunksToReserve")
end

#  storage -   uint public numberOfPunksReserved
#
#  
sig "numberOfPunksReserved", outputs: ["uint256"]
def numberOfPunksReserved()
  do_call("numberOfPunksReserved")
end

#  storage -   uint public punksRemainingToAssign
#
sig "punksRemainingToAssign", outputs: ["uint256"]
def punksRemainingToAssign()
  do_call("punksRemainingToAssign")
end

#  storage - mapping (address => uint) public pendingWithdrawals
#
#  
#  
#  
sig "pendingWithdrawals", inputs: ["address"], outputs: ["uint256"]
def pendingWithdrawals(arg0)
  do_call("pendingWithdrawals", arg0)
end

end   ## class PunksV1

