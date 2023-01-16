# NounsSeeder contract / (blockchain) services / function calls
#
#  auto-generated via abigen (see https://rubygems.org/gems/abigen) on 2023-01-16 16:17:10 UTC
#  - 1 query functions(s)
#  - 0 helper functions(s)


class  NounsSeeder <  Ethlite::Contract

  address "0xcc8a0fb5ab3c7132c1b2a0109142fb112c4ce515"

#  function **generateSeed**(uint256 nounId, contract INounsDescriptor descriptor) ⇒ (struct INounsSeeder.Seed _) _readonly_
def generateSeed(nounId, descriptor)
  do_call("generateSeed", nounId, descriptor)
end
sig "generateSeed", inputs: ["uint256","address"], outputs: ["(uint48,uint48,uint48,uint48,uint48)"]

end   ## class NounsSeeder

