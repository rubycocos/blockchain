

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


   UINT_MAX = 2**256 - 1   ## same as 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
   UINT_MIN = 0
   INT_MAX  = 2**255 - 1   ## same as  57896044618658097711785492504343953926634992332820282019728792003956564819967
   INT_MIN  = -2**255      ## same as -57896044618658097711785492504343953926634992332820282019728792003956564819968


    ### todo/check - what is TT the abbrevation for ???
    ## todo/check  - used where and why???
    TT32   = 2**32     ## same as 0x100000000
    TT40   = 2**40     ## same as 0x10000000000
    TT160  = 2**160    ## same as 0x10000000000000000000000000000000000000000
    TT256  = 2**256    ## same as 0x10000000000000000000000000000000000000000000000000000000000000000
    TT64M1 = 2**64 - 1  ## same as 0xffffffffffffffff
end  # module ABI



require_relative 'abicoder/utils'


require_relative 'abicoder/type'
require_relative 'abicoder/type_tuple'

require_relative 'abicoder/encoder'
require_relative 'abicoder/decoder'


module ABI
  def self.encoder
    @encoder ||= Encoder.new
  end
  def self.decoder
    @decoder ||= Decoder.new
  end


  def self.encode( types, args )
      encoder.encode( types, args )
  end

  def self.decode( types, data, raise_errors = false )
      decoder.decode( types, data, raise_errors )
  end

  ## add alternate names  - why? why not?
  class << self
     alias_method :encode_abi, :encode
     alias_method :decode_abi, :decode
  end
end    ## module ABI


################
## add convenience alternate spellings - why? why not?
Abi = ABI



puts ABICoder.banner   ## say hello