require 'cocos'
require 'bytes'
require 'digest-lite'


## extend String
class String
  alias_method :hexdigest, :bin_to_hex   ## note: bin_to_hex added via Bytes!!!

    # given two numeric strings,
    # returns the bitwise xor string
    def ^(other)
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
end  # class String


def keccak256( bin )
  Digest::KeccakLite.new( 256 ).digest( bin )
end

def sig( bin )
  keccak256( bin )[0,4]
end



## our own code
require_relative 'abiparser/version'    # note: let version always go first
require_relative 'abiparser/param'
require_relative 'abiparser/constructor'
require_relative 'abiparser/function'
require_relative 'abiparser/interface'

require_relative 'abiparser/export/interface.rb'




module ABI



  ## rename to QueryInterface or SupportInterface
  ##   or InterfaceType or such - why? why not?
class InterfaceId

  attr_reader :interface_id

  def initialize( *functions )
    @functions = functions
    @selectors = {}

    @functions.each do |func|
      sig = func
      sighash =  keccak256( sig )[0,4].hexdigest
      puts "0x#{sighash} => #{sig}"

      ## assert - no duplicates allowed
      if @selectors[sighash]
        puts "!! ERROR - duplicate function signature #{sig}; already in use; sorry"
        exit 1
      end

      @selectors[sighash] = sig
    end
    @interface_id = calc_interface_id
  end


  def calc_interface_id
    interface_id = nil
    @selectors.each do |sighash,_|
      sighash = sighash.hex_to_bin   ## note: convert to binary string (from hexstring)!!
      interface_id = if interface_id.nil?
        sighash   ## init with sighash
      else
        interface_id ^ sighash   ## use xor
      end
    end
    interface_id.hexdigest
  end

  SIGHASH_RX = /\A
                (0x)?
                (?<sighash>[0-9a-f]{8})
                \z/ix

 def support?( sig )
     sighash =  if m=SIGHASH_RX.match( sig )
                  m[:sighash].downcase  ## assume it's sighash (hexstring)
                else
                  ## for convenience allow (white)spaces; auto-strip - why? why not?
                  sig = sig.gsub( /[ \r\t\n]/, '' )
                  keccak256( sig )[0,4].hexdigest
                end

     if @selectors[ sighash ]
        true
     else
        false
     end
  end
  alias_method :supports?, :support?   ## add alternate spelling - why? why not?

end  ## class InterfaceId



end  # module ABI




## note: make "global" constants - why? why not?

## IERC20  0x36372b07
IERC20  = ABI::InterfaceId.new(
   'totalSupply()',
   'balanceOf(address)',
   'allowance(address,address)',
   'transfer(address,uint256)',
   'approve(address,uint256)',
   'transferFrom(address,address,uint256)' )


## IERC721  0x80ac58cd
IERC721 = ABI::InterfaceId.new(
  'balanceOf(address)',
  'ownerOf(uint256)',
  'approve(address,uint256)',
  'getApproved(uint256)',
  'setApprovalForAll(address,bool)',
  'isApprovedForAll(address,address)',
  'transferFrom(address,address,uint256)',
  'safeTransferFrom(address,address,uint256)',
  'safeTransferFrom(address,address,uint256,bytes)' )






module ABI
  def self.read( path )  Interface.read( path ); end

  def self.parse( data ) Interface.parse( data ); end
end  # module ABI


## add convenience alternate spellings - why? why not?
Abi = ABI


puts AbiParser.banner

