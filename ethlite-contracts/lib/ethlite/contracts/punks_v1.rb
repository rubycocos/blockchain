#########################
# PunksV1 contract / (blockchain) services / function calls
#    auto-generated via abigen (see https://rubygems.org/gems/abigen) on 2023-01-09 17:48:57 UTC
#    - 14 query functions(s)

class  PunksV1 <  Ethlite::Contract

  address "0x6ba6f2207e343923ba692e5cae646fb0f566db8d"

#  function **name**() ⇒ (string _) _readonly_
sig "name", outputs: ["string"]
def name()
  do_call("name")
end

#  function **punksOfferedForSale**(uint256 _) ⇒ (bool isForSale, uint256 punkIndex, address seller, uint256 minValue, address onlySellTo) _readonly_
sig "punksOfferedForSale", inputs: ["uint256"], outputs: ["bool","uint256","address","uint256","address"]
def punksOfferedForSale(arg0)
  do_call("punksOfferedForSale", arg0)
end

#  function **totalSupply**() ⇒ (uint256 _) _readonly_
sig "totalSupply", outputs: ["uint256"]
def totalSupply()
  do_call("totalSupply")
end

#  function **decimals**() ⇒ (uint8 _) _readonly_
sig "decimals", outputs: ["uint8"]
def decimals()
  do_call("decimals")
end

#  function **imageHash**() ⇒ (string _) _readonly_
sig "imageHash", outputs: ["string"]
def imageHash()
  do_call("imageHash")
end

#  function **nextPunkIndexToAssign**() ⇒ (uint256 _) _readonly_
sig "nextPunkIndexToAssign", outputs: ["uint256"]
def nextPunkIndexToAssign()
  do_call("nextPunkIndexToAssign")
end

#  function **punkIndexToAddress**(uint256 _) ⇒ (address _) _readonly_
sig "punkIndexToAddress", inputs: ["uint256"], outputs: ["address"]
def punkIndexToAddress(arg0)
  do_call("punkIndexToAddress", arg0)
end

#  function **standard**() ⇒ (string _) _readonly_
sig "standard", outputs: ["string"]
def standard()
  do_call("standard")
end

#  function **balanceOf**(address _) ⇒ (uint256 _) _readonly_
sig "balanceOf", inputs: ["address"], outputs: ["uint256"]
def balanceOf(arg0)
  do_call("balanceOf", arg0)
end

#  function **symbol**() ⇒ (string _) _readonly_
sig "symbol", outputs: ["string"]
def symbol()
  do_call("symbol")
end

#  function **numberOfPunksToReserve**() ⇒ (uint256 _) _readonly_
sig "numberOfPunksToReserve", outputs: ["uint256"]
def numberOfPunksToReserve()
  do_call("numberOfPunksToReserve")
end

#  function **numberOfPunksReserved**() ⇒ (uint256 _) _readonly_
sig "numberOfPunksReserved", outputs: ["uint256"]
def numberOfPunksReserved()
  do_call("numberOfPunksReserved")
end

#  function **punksRemainingToAssign**() ⇒ (uint256 _) _readonly_
sig "punksRemainingToAssign", outputs: ["uint256"]
def punksRemainingToAssign()
  do_call("punksRemainingToAssign")
end

#  function **pendingWithdrawals**(address _) ⇒ (uint256 _) _readonly_
sig "pendingWithdrawals", inputs: ["address"], outputs: ["uint256"]
def pendingWithdrawals(arg0)
  do_call("pendingWithdrawals", arg0)
end

end   ## class PunksV1

