## 3rd party gems
require 'ethlite'




## our own code

# shared base contract machinery - keep here
##      or rename to Base or such - why? why not?
require_relative 'ethlite/contract'

### generated contracts via abigen
require_relative 'ethlite/contracts/punks_v1'
require_relative 'ethlite/contracts/punk_blocks'
require_relative 'ethlite/contracts/punks_meta'

require_relative 'ethlite/contracts/mooncats'
require_relative 'ethlite/contracts/phunks_v2'
require_relative 'ethlite/contracts/punks_data'
require_relative 'ethlite/contracts/synth_punks'
require_relative 'ethlite/contracts/moonbirds'
require_relative 'ethlite/contracts/marcs'
require_relative 'ethlite/contracts/mad_camels'

