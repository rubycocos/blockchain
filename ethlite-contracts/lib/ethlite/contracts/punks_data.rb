# PunksData contract / (blockchain) services / function calls
#
#  auto-generated via abigen (see https://rubygems.org/gems/abigen) on 2023-01-15 16:36:46 UTC
#  - 3 query functions(s)
#  - 0 helper functions(s)


class  PunksData <  Ethlite::Contract

  address "0x16f5a35647d6f03d5d3da7b35409d65ba03af3b2"

#  function **punkAttributes**(uint16 index) ⇒ (string text) _readonly_
def punkAttributes(index)
  do_call("punkAttributes", index)
end
sig "punkAttributes", inputs: ["uint16"], outputs: ["string"]

#  function **punkImage**(uint16 index) ⇒ (bytes _) _readonly_
def punkImage(index)
  do_call("punkImage", index)
end
sig "punkImage", inputs: ["uint16"], outputs: ["bytes"]

#  function **punkImageSvg**(uint16 index) ⇒ (string svg) _readonly_
def punkImageSvg(index)
  do_call("punkImageSvg", index)
end
sig "punkImageSvg", inputs: ["uint16"], outputs: ["string"]

end   ## class PunksData

