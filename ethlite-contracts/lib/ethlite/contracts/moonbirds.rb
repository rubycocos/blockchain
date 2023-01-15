# Moonbirds contract / (blockchain) services / function calls
#
#  auto-generated via abigen (see https://rubygems.org/gems/abigen) on 2023-01-15 16:36:51 UTC
#  - 33 query functions(s)
#  - 0 helper functions(s)


class  Moonbirds <  Ethlite::Contract

  address "0x23581767a106ae21c074b2276d25e5c3e136a68b"

#  function **DEFAULT_ADMIN_ROLE**() ⇒ (bytes32 _) _readonly_
def DEFAULT_ADMIN_ROLE()
  do_call("DEFAULT_ADMIN_ROLE")
end
sig "DEFAULT_ADMIN_ROLE", outputs: ["bytes32"]

#  function **EXPULSION_ROLE**() ⇒ (bytes32 _) _readonly_
def EXPULSION_ROLE()
  do_call("EXPULSION_ROLE")
end
sig "EXPULSION_ROLE", outputs: ["bytes32"]

#  function **alreadyMinted**(address to, bytes32 nonce) ⇒ (bool _) _readonly_
def alreadyMinted(to, nonce)
  do_call("alreadyMinted", to, nonce)
end
sig "alreadyMinted", inputs: ["address","bytes32"], outputs: ["bool"]

#  function **balanceOf**(address owner) ⇒ (uint256 _) _readonly_
def balanceOf(owner)
  do_call("balanceOf", owner)
end
sig "balanceOf", inputs: ["address"], outputs: ["uint256"]

#  function **baseTokenURI**() ⇒ (string _) _readonly_
def baseTokenURI()
  do_call("baseTokenURI")
end
sig "baseTokenURI", outputs: ["string"]

#  function **beneficiary**() ⇒ (address payable _) _readonly_
def beneficiary()
  do_call("beneficiary")
end
sig "beneficiary", outputs: ["address"]

#  function **cost**(uint256 n, uint256 _) ⇒ (uint256 _) _readonly_
def cost(n, arg1)
  do_call("cost", n, arg1)
end
sig "cost", inputs: ["uint256","uint256"], outputs: ["uint256"]

#  function **getApproved**(uint256 tokenId) ⇒ (address _) _readonly_
def getApproved(tokenId)
  do_call("getApproved", tokenId)
end
sig "getApproved", inputs: ["uint256"], outputs: ["address"]

#  function **getRoleAdmin**(bytes32 role) ⇒ (bytes32 _) _readonly_
def getRoleAdmin(role)
  do_call("getRoleAdmin", role)
end
sig "getRoleAdmin", inputs: ["bytes32"], outputs: ["bytes32"]

#  function **getRoleMember**(bytes32 role, uint256 index) ⇒ (address _) _readonly_
def getRoleMember(role, index)
  do_call("getRoleMember", role, index)
end
sig "getRoleMember", inputs: ["bytes32","uint256"], outputs: ["address"]

#  function **getRoleMemberCount**(bytes32 role) ⇒ (uint256 _) _readonly_
def getRoleMemberCount(role)
  do_call("getRoleMemberCount", role)
end
sig "getRoleMemberCount", inputs: ["bytes32"], outputs: ["uint256"]

#  function **hasRole**(bytes32 role, address account) ⇒ (bool _) _readonly_
def hasRole(role, account)
  do_call("hasRole", role, account)
end
sig "hasRole", inputs: ["bytes32","address"], outputs: ["bool"]

#  function **isApprovedForAll**(address owner, address operator) ⇒ (bool _) _readonly_
def isApprovedForAll(owner, operator)
  do_call("isApprovedForAll", owner, operator)
end
sig "isApprovedForAll", inputs: ["address","address"], outputs: ["bool"]

#  function **name**() ⇒ (string _) _readonly_
def name()
  do_call("name")
end
sig "name", outputs: ["string"]

#  function **nestingOpen**() ⇒ (bool _) _readonly_
def nestingOpen()
  do_call("nestingOpen")
end
sig "nestingOpen", outputs: ["bool"]

#  function **nestingPeriod**(uint256 tokenId) ⇒ (bool nesting, uint256 current, uint256 total) _readonly_
def nestingPeriod(tokenId)
  do_call("nestingPeriod", tokenId)
end
sig "nestingPeriod", inputs: ["uint256"], outputs: ["bool","uint256","uint256"]

#  function **owner**() ⇒ (address _) _readonly_
def owner()
  do_call("owner")
end
sig "owner", outputs: ["address"]

#  function **ownerOf**(uint256 tokenId) ⇒ (address _) _readonly_
def ownerOf(tokenId)
  do_call("ownerOf", tokenId)
end
sig "ownerOf", inputs: ["uint256"], outputs: ["address"]

#  function **paused**() ⇒ (bool _) _readonly_
def paused()
  do_call("paused")
end
sig "paused", outputs: ["bool"]

#  function **price**() ⇒ (uint256 _) _readonly_
def price()
  do_call("price")
end
sig "price", outputs: ["uint256"]

#  function **proof**() ⇒ (contract IERC721 _) _readonly_
def proof()
  do_call("proof")
end
sig "proof", outputs: ["address"]

#  function **proofClaimsRemaining**(uint256 tokenId) ⇒ (uint256 _) _readonly_
def proofClaimsRemaining(tokenId)
  do_call("proofClaimsRemaining", tokenId)
end
sig "proofClaimsRemaining", inputs: ["uint256"], outputs: ["uint256"]

#  function **proofMintingOpen**() ⇒ (bool _) _readonly_
def proofMintingOpen()
  do_call("proofMintingOpen")
end
sig "proofMintingOpen", outputs: ["bool"]

#  function **proofPoolRemaining**() ⇒ (uint256 _) _readonly_
def proofPoolRemaining()
  do_call("proofPoolRemaining")
end
sig "proofPoolRemaining", outputs: ["uint256"]

#  function **renderingContract**() ⇒ (contract ITokenURIGenerator _) _readonly_
def renderingContract()
  do_call("renderingContract")
end
sig "renderingContract", outputs: ["address"]

#  function **royaltyInfo**(uint256 _tokenId, uint256 _salePrice) ⇒ (address _, uint256 _) _readonly_
def royaltyInfo(_tokenId, _salePrice)
  do_call("royaltyInfo", _tokenId, _salePrice)
end
sig "royaltyInfo", inputs: ["uint256","uint256"], outputs: ["address","uint256"]

#  function **sellerConfig**() ⇒ (uint256 totalInventory, uint256 maxPerAddress, uint256 maxPerTx, uint248 freeQuota, bool reserveFreeQuota, bool lockFreeQuota, bool lockTotalInventory) _readonly_
def sellerConfig()
  do_call("sellerConfig")
end
sig "sellerConfig", outputs: ["uint256","uint256","uint256","uint248","bool","bool","bool"]

#  function **supportsInterface**(bytes4 interfaceId) ⇒ (bool _) _readonly_
def supportsInterface(interfaceId)
  do_call("supportsInterface", interfaceId)
end
sig "supportsInterface", inputs: ["bytes4"], outputs: ["bool"]

#  function **symbol**() ⇒ (string _) _readonly_
def symbol()
  do_call("symbol")
end
sig "symbol", outputs: ["string"]

#  function **tokenURI**(uint256 tokenId) ⇒ (string _) _readonly_
def tokenURI(tokenId)
  do_call("tokenURI", tokenId)
end
sig "tokenURI", inputs: ["uint256"], outputs: ["string"]

#  function **totalSold**() ⇒ (uint256 _) _readonly_
def totalSold()
  do_call("totalSold")
end
sig "totalSold", outputs: ["uint256"]

#  function **totalSupply**() ⇒ (uint256 _) _readonly_
def totalSupply()
  do_call("totalSupply")
end
sig "totalSupply", outputs: ["uint256"]

#  function **usedMessages**(bytes32 _) ⇒ (bool _) _readonly_
def usedMessages(arg0)
  do_call("usedMessages", arg0)
end
sig "usedMessages", inputs: ["bytes32"], outputs: ["bool"]

end   ## class Moonbirds

