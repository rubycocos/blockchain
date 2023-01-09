## 3rd party gems
require 'ethlite'




## out own code

# shared base contract machinery - keep here
##      or rename to Base or such - why? why not?
require_relative 'ethlite/contract'

### generated contracts via abigen
require_relative 'ethlite/contracts/punks_v1'
require_relative 'ethlite/contracts/punk_blocks'


