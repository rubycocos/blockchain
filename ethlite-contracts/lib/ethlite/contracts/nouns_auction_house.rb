# NounsAuctionHouse contract / (blockchain) services / function calls
#
#  auto-generated via abigen (see https://rubygems.org/gems/abigen) on 2023-01-16 16:17:13 UTC
#  - 9 query functions(s)
#  - 0 helper functions(s)


class  NounsAuctionHouse <  Ethlite::Contract

  address "0xf15a943787014461d94da08ad4040f79cd7c124e"

#  function **auction**() ⇒ (uint256 nounId, uint256 amount, uint256 startTime, uint256 endTime, address payable bidder, bool settled) _readonly_
def auction()
  do_call("auction")
end
sig "auction", outputs: ["uint256","uint256","uint256","uint256","address","bool"]

#  function **duration**() ⇒ (uint256 _) _readonly_
def duration()
  do_call("duration")
end
sig "duration", outputs: ["uint256"]

#  function **minBidIncrementPercentage**() ⇒ (uint8 _) _readonly_
def minBidIncrementPercentage()
  do_call("minBidIncrementPercentage")
end
sig "minBidIncrementPercentage", outputs: ["uint8"]

#  function **nouns**() ⇒ (contract INounsToken _) _readonly_
def nouns()
  do_call("nouns")
end
sig "nouns", outputs: ["address"]

#  function **owner**() ⇒ (address _) _readonly_
def owner()
  do_call("owner")
end
sig "owner", outputs: ["address"]

#  function **paused**() ⇒ (bool _) _readonly_
def paused()
  do_call("paused")
end
sig "paused", outputs: ["bool"]

#  function **reservePrice**() ⇒ (uint256 _) _readonly_
def reservePrice()
  do_call("reservePrice")
end
sig "reservePrice", outputs: ["uint256"]

#  function **timeBuffer**() ⇒ (uint256 _) _readonly_
def timeBuffer()
  do_call("timeBuffer")
end
sig "timeBuffer", outputs: ["uint256"]

#  function **weth**() ⇒ (address _) _readonly_
def weth()
  do_call("weth")
end
sig "weth", outputs: ["address"]

end   ## class NounsAuctionHouse

