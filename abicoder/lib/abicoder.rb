

## our own code
require_relative 'abicoder/version'    # note: let version always go first

module ABI
 ###################
  ### some (shared) constants  (move to constants.rb or such - why? why not?)

   ## todo/check:  use auto-freeze string literals magic comment - why? why not?
   ##
   ## todo/fix: move  BYTE_EMPTY, BYTE_ZERO, BYTE_ONE to upstream to bytes gem
   ##    and make "global" constants - why? why not?

   BYTE_EMPTY = "".b.freeze
   BYTE_ZERO  = "\x00".b.freeze
   BYTE_ONE   = "\x01".b.freeze      ## note: used for encoding bool for now


   UINT_MAX = 2**256 - 1
   UINT_MIN = 0
   INT_MAX  = 2**255 - 1
   INT_MIN  = -2**255


    ### todo/check - what is TT the abbrevation for ???
    TT32   = 2**32
    TT40   = 2**40      ## todo/check  - used where and why???
    TT160  = 2**160     ## todo/check  - used where and why???
    TT256  = 2**256     ## todo/check  - used where and why???
    TT64M1 = 2**64 - 1  ## todo/check  - used where and why???
end  # module ABI

require_relative 'abicoder/utils'


require_relative 'abicoder/type'
require_relative 'abicoder/type_tuple'

require_relative 'abicoder/codec'





puts ABICoder.banner   ## say hello