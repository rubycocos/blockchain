# Mooncats contract / (blockchain) services / function calls
#
#  auto-generated via abigen (see https://rubygems.org/gems/abigen) on 2023-01-15 16:36:44 UTC
#  - 23 query functions(s)
#  - 0 helper functions(s)


class  Mooncats <  Ethlite::Contract

  address "0x60cd862c9c687a9de49aecdc3a99b74a4fc54ab6"

#  function **name**() ⇒ (string _) _readonly_
def name()
  do_call("name")
end
sig "name", outputs: ["string"]

#  function **remainingGenesisCats**() ⇒ (uint16 _) _readonly_
def remainingGenesisCats()
  do_call("remainingGenesisCats")
end
sig "remainingGenesisCats", outputs: ["uint16"]

#  function **totalSupply**() ⇒ (uint256 _) _readonly_
def totalSupply()
  do_call("totalSupply")
end
sig "totalSupply", outputs: ["uint256"]

#  function **remainingCats**() ⇒ (uint16 _) _readonly_
def remainingCats()
  do_call("remainingCats")
end
sig "remainingCats", outputs: ["uint16"]

#  function **mode**() ⇒ (uint8 _) _readonly_
def mode()
  do_call("mode")
end
sig "mode", outputs: ["uint8"]

#  function **getCatDetails**(bytes5 catId) ⇒ (bytes5 id, address owner, bytes32 name, address onlyOfferTo, uint256 offerPrice, address requester, uint256 requestPrice) _readonly_
def getCatDetails(catId)
  do_call("getCatDetails", catId)
end
sig "getCatDetails", inputs: ["bytes5"], outputs: ["bytes5","address","bytes32","address","uint256","address","uint256"]

#  function **decimals**() ⇒ (uint8 _) _readonly_
def decimals()
  do_call("decimals")
end
sig "decimals", outputs: ["uint8"]

#  function **getCatOwners**() ⇒ (address[] _) _readonly_
def getCatOwners()
  do_call("getCatOwners")
end
sig "getCatOwners", outputs: ["address[]"]

#  function **catOwners**(bytes5 _) ⇒ (address _) _readonly_
def catOwners(arg0)
  do_call("catOwners", arg0)
end
sig "catOwners", inputs: ["bytes5"], outputs: ["address"]

#  function **rescueOrder**(uint256 _) ⇒ (bytes5 _) _readonly_
def rescueOrder(arg0)
  do_call("rescueOrder", arg0)
end
sig "rescueOrder", inputs: ["uint256"], outputs: ["bytes5"]

#  function **getCatIds**() ⇒ (bytes5[] _) _readonly_
def getCatIds()
  do_call("getCatIds")
end
sig "getCatIds", outputs: ["bytes5[]"]

#  function **balanceOf**(address _) ⇒ (uint256 _) _readonly_
def balanceOf(arg0)
  do_call("balanceOf", arg0)
end
sig "balanceOf", inputs: ["address"], outputs: ["uint256"]

#  function **getCatNames**() ⇒ (bytes32[] _) _readonly_
def getCatNames()
  do_call("getCatNames")
end
sig "getCatNames", outputs: ["bytes32[]"]

#  function **adoptionOffers**(bytes5 _) ⇒ (bool exists, bytes5 catId, address seller, uint256 price, address onlyOfferTo) _readonly_
def adoptionOffers(arg0)
  do_call("adoptionOffers", arg0)
end
sig "adoptionOffers", inputs: ["bytes5"], outputs: ["bool","bytes5","address","uint256","address"]

#  function **catNames**(bytes5 _) ⇒ (bytes32 _) _readonly_
def catNames(arg0)
  do_call("catNames", arg0)
end
sig "catNames", inputs: ["bytes5"], outputs: ["bytes32"]

#  function **symbol**() ⇒ (string _) _readonly_
def symbol()
  do_call("symbol")
end
sig "symbol", outputs: ["string"]

#  function **getCatRequestPrices**() ⇒ (uint256[] _) _readonly_
def getCatRequestPrices()
  do_call("getCatRequestPrices")
end
sig "getCatRequestPrices", outputs: ["uint256[]"]

#  function **searchSeed**() ⇒ (bytes32 _) _readonly_
def searchSeed()
  do_call("searchSeed")
end
sig "searchSeed", outputs: ["bytes32"]

#  function **imageGenerationCodeMD5**() ⇒ (bytes16 _) _readonly_
def imageGenerationCodeMD5()
  do_call("imageGenerationCodeMD5")
end
sig "imageGenerationCodeMD5", outputs: ["bytes16"]

#  function **adoptionRequests**(bytes5 _) ⇒ (bool exists, bytes5 catId, address requester, uint256 price) _readonly_
def adoptionRequests(arg0)
  do_call("adoptionRequests", arg0)
end
sig "adoptionRequests", inputs: ["bytes5"], outputs: ["bool","bytes5","address","uint256"]

#  function **getCatOfferPrices**() ⇒ (uint256[] _) _readonly_
def getCatOfferPrices()
  do_call("getCatOfferPrices")
end
sig "getCatOfferPrices", outputs: ["uint256[]"]

#  function **rescueIndex**() ⇒ (uint16 _) _readonly_
def rescueIndex()
  do_call("rescueIndex")
end
sig "rescueIndex", outputs: ["uint16"]

#  function **pendingWithdrawals**(address _) ⇒ (uint256 _) _readonly_
def pendingWithdrawals(arg0)
  do_call("pendingWithdrawals", arg0)
end
sig "pendingWithdrawals", inputs: ["address"], outputs: ["uint256"]

end   ## class Mooncats

