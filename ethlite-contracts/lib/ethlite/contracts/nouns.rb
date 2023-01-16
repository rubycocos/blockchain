# Nouns contract / (blockchain) services / function calls
#
#  auto-generated via abigen (see https://rubygems.org/gems/abigen) on 2023-01-16 16:17:12 UTC
#  - 33 query functions(s)
#  - 0 helper functions(s)


class  Nouns <  Ethlite::Contract

  address "0x9c8ff314c9bc7f6e59a9d9225fb22946427edc03"

#  function **DELEGATION_TYPEHASH**() ⇒ (bytes32 _) _readonly_
def DELEGATION_TYPEHASH()
  do_call("DELEGATION_TYPEHASH")
end
sig "DELEGATION_TYPEHASH", outputs: ["bytes32"]

#  function **DOMAIN_TYPEHASH**() ⇒ (bytes32 _) _readonly_
def DOMAIN_TYPEHASH()
  do_call("DOMAIN_TYPEHASH")
end
sig "DOMAIN_TYPEHASH", outputs: ["bytes32"]

#  function **balanceOf**(address owner) ⇒ (uint256 _) _readonly_
def balanceOf(owner)
  do_call("balanceOf", owner)
end
sig "balanceOf", inputs: ["address"], outputs: ["uint256"]

#  function **checkpoints**(address _, uint32 _) ⇒ (uint32 fromBlock, uint96 votes) _readonly_
def checkpoints(arg0, arg1)
  do_call("checkpoints", arg0, arg1)
end
sig "checkpoints", inputs: ["address","uint32"], outputs: ["uint32","uint96"]

#  function **contractURI**() ⇒ (string _) _readonly_
def contractURI()
  do_call("contractURI")
end
sig "contractURI", outputs: ["string"]

#  function **dataURI**(uint256 tokenId) ⇒ (string _) _readonly_
def dataURI(tokenId)
  do_call("dataURI", tokenId)
end
sig "dataURI", inputs: ["uint256"], outputs: ["string"]

#  function **decimals**() ⇒ (uint8 _) _readonly_
def decimals()
  do_call("decimals")
end
sig "decimals", outputs: ["uint8"]

#  function **delegates**(address delegator) ⇒ (address _) _readonly_
def delegates(delegator)
  do_call("delegates", delegator)
end
sig "delegates", inputs: ["address"], outputs: ["address"]

#  function **descriptor**() ⇒ (contract INounsDescriptor _) _readonly_
def descriptor()
  do_call("descriptor")
end
sig "descriptor", outputs: ["address"]

#  function **getApproved**(uint256 tokenId) ⇒ (address _) _readonly_
def getApproved(tokenId)
  do_call("getApproved", tokenId)
end
sig "getApproved", inputs: ["uint256"], outputs: ["address"]

#  function **getCurrentVotes**(address account) ⇒ (uint96 _) _readonly_
def getCurrentVotes(account)
  do_call("getCurrentVotes", account)
end
sig "getCurrentVotes", inputs: ["address"], outputs: ["uint96"]

#  function **getPriorVotes**(address account, uint256 blockNumber) ⇒ (uint96 _) _readonly_
def getPriorVotes(account, blockNumber)
  do_call("getPriorVotes", account, blockNumber)
end
sig "getPriorVotes", inputs: ["address","uint256"], outputs: ["uint96"]

#  function **isApprovedForAll**(address owner, address operator) ⇒ (bool _) _readonly_
def isApprovedForAll(owner, operator)
  do_call("isApprovedForAll", owner, operator)
end
sig "isApprovedForAll", inputs: ["address","address"], outputs: ["bool"]

#  function **isDescriptorLocked**() ⇒ (bool _) _readonly_
def isDescriptorLocked()
  do_call("isDescriptorLocked")
end
sig "isDescriptorLocked", outputs: ["bool"]

#  function **isMinterLocked**() ⇒ (bool _) _readonly_
def isMinterLocked()
  do_call("isMinterLocked")
end
sig "isMinterLocked", outputs: ["bool"]

#  function **isSeederLocked**() ⇒ (bool _) _readonly_
def isSeederLocked()
  do_call("isSeederLocked")
end
sig "isSeederLocked", outputs: ["bool"]

#  function **minter**() ⇒ (address _) _readonly_
def minter()
  do_call("minter")
end
sig "minter", outputs: ["address"]

#  function **name**() ⇒ (string _) _readonly_
def name()
  do_call("name")
end
sig "name", outputs: ["string"]

#  function **nonces**(address _) ⇒ (uint256 _) _readonly_
def nonces(arg0)
  do_call("nonces", arg0)
end
sig "nonces", inputs: ["address"], outputs: ["uint256"]

#  function **noundersDAO**() ⇒ (address _) _readonly_
def noundersDAO()
  do_call("noundersDAO")
end
sig "noundersDAO", outputs: ["address"]

#  function **numCheckpoints**(address _) ⇒ (uint32 _) _readonly_
def numCheckpoints(arg0)
  do_call("numCheckpoints", arg0)
end
sig "numCheckpoints", inputs: ["address"], outputs: ["uint32"]

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

#  function **proxyRegistry**() ⇒ (contract IProxyRegistry _) _readonly_
def proxyRegistry()
  do_call("proxyRegistry")
end
sig "proxyRegistry", outputs: ["address"]

#  function **seeder**() ⇒ (contract INounsSeeder _) _readonly_
def seeder()
  do_call("seeder")
end
sig "seeder", outputs: ["address"]

#  function **seeds**(uint256 _) ⇒ (uint48 background, uint48 body, uint48 accessory, uint48 head, uint48 glasses) _readonly_
def seeds(arg0)
  do_call("seeds", arg0)
end
sig "seeds", inputs: ["uint256"], outputs: ["uint48","uint48","uint48","uint48","uint48"]

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

#  function **tokenByIndex**(uint256 index) ⇒ (uint256 _) _readonly_
def tokenByIndex(index)
  do_call("tokenByIndex", index)
end
sig "tokenByIndex", inputs: ["uint256"], outputs: ["uint256"]

#  function **tokenOfOwnerByIndex**(address owner, uint256 index) ⇒ (uint256 _) _readonly_
def tokenOfOwnerByIndex(owner, index)
  do_call("tokenOfOwnerByIndex", owner, index)
end
sig "tokenOfOwnerByIndex", inputs: ["address","uint256"], outputs: ["uint256"]

#  function **tokenURI**(uint256 tokenId) ⇒ (string _) _readonly_
def tokenURI(tokenId)
  do_call("tokenURI", tokenId)
end
sig "tokenURI", inputs: ["uint256"], outputs: ["string"]

#  function **totalSupply**() ⇒ (uint256 _) _readonly_
def totalSupply()
  do_call("totalSupply")
end
sig "totalSupply", outputs: ["uint256"]

#  function **votesToDelegate**(address delegator) ⇒ (uint96 _) _readonly_
def votesToDelegate(delegator)
  do_call("votesToDelegate", delegator)
end
sig "votesToDelegate", inputs: ["address"], outputs: ["uint96"]

end   ## class Nouns

