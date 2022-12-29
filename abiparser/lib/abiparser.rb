require 'cocos'
require 'bytes'
require 'digest-lite'


## extend String
class String
  alias_method :hexdigest, :bin_to_hex   ## note: bin_to_hex added via Bytes!!!

    # given two numeric strings,
    # returns the bitwise xor string
    def xor(other)
        a = self.bytes
        b = other.bytes
        ## todo/check: cut-off on lower count (lc) - why? why not?
        lc = (a.size < b.size) ? a.size : b.size
        c = []
        lc.times do |i|
           c << (a[i] ^ b[i])
        end
        c = c.pack( 'C*' )
        puts "#{self.bin_to_hex} ^ #{other.bin_to_hex} = #{c.bin_to_hex}<"
        c
    end
    alias_method :^, :xor
end  # class String



def keccak256( bin )
  Digest::KeccakLite.new( 256 ).digest( bin )
end

def sig( bin )
  keccak256( bin )[0,4]
end



## our own code
require_relative 'abiparser/version'    # note: let version always go first
require_relative 'abiparser/type'
require_relative 'abiparser/type_tuple'

require_relative 'abiparser/param'
require_relative 'abiparser/constructor'
require_relative 'abiparser/function'
require_relative 'abiparser/utils'
require_relative 'abiparser/contract'
require_relative 'abiparser/interface'

require_relative 'abiparser/export/interface'




## note: make "global" constants - why? why not?

## IERC165  0x01ffc9a7
IERC165 = ABI::Interface.new(
  'supportsInterface(bytes4)',
)

## IERC20  0x36372b07
IERC20  = ABI::Interface.new(
   'totalSupply()',
   'balanceOf(address)',
   'allowance(address,address)',
   'transfer(address,uint256)',
   'approve(address,uint256)',
   'transferFrom(address,address,uint256)'
)

## IERC20_NAME 0x06fdde03
IERC20_NAME = ABI::Interface.new(
  'name()'
)

## IERC20_SYMBOL 0x95d89b41
IERC20_SYMBOL = ABI::Interface.new(
  'symbol()'
)

## IERC20_DECIMALS 0x313ce567
IERC20_DECIMALS = ABI::Interface.new(
  'decimals()'
)

## IERC721  0x80ac58cd
IERC721 = ABI::Interface.new(
  'balanceOf(address)',
  'ownerOf(uint256)',
  'approve(address,uint256)',
  'getApproved(uint256)',
  'setApprovalForAll(address,bool)',
  'isApprovedForAll(address,address)',
  'transferFrom(address,address,uint256)',
  'safeTransferFrom(address,address,uint256)',
  'safeTransferFrom(address,address,uint256,bytes)'
)

## IERC721_METADATA  0x5b5e139f
IERC721_METADATA   = ABI::Interface.new(
  'name()',
  'symbol()',
  'tokenURI(uint256)'
)

## IERC721_ENUMERABLE  0x780e9d63
IERC721_ENUMERABLE   = ABI::Interface.new(
  'tokenOfOwnerByIndex(address,uint256)',
  'totalSupply()',
  'tokenByIndex(uint256)'
)





module ABI
  def self.read( path )  Contract.read( path ); end

  def self.parse( data ) Contract.parse( data ); end
end  # module ABI


## add convenience alternate spellings - why? why not?
Abi = ABI


puts AbiParser.banner

