###
#  to run use
#     ruby -I ./lib sandbox/test_interfaces.rb


require 'ethq'


require 'bytes'

## extend String
class String
  alias_method :hexdigest, :bin_to_hex   ## note: bin_to_hex added via Bytes!!!
end


punksv3_eth   = '0xD33c078C2486B7Be0F7B4DDa9B14F35163B949e0'
madcamels_eth = '0xad8474ba5a7f6abc52708f171f57fefc5cdc8c1c'

contract_address =  madcamels_eth


c = EthQ::Contract.new( contract_address )
bytes4 = '0x01ffc9a7'.hex_to_bin
pp  c.supportsInterface( bytes4 )




Interface = Struct.new( :name, :id )

IERC165                = Interface.new( 'ERC165', '0x01ffc9a7'.hex_to_bin )
IERC20                 = Interface.new( 'ERC20',  '0x36372b07'.hex_to_bin )
IERC721                = Interface.new( 'ERC721', '0x80ac58cd'.hex_to_bin )
IERC721_METADATA       = Interface.new( 'ERC721_METADATA', '0x5b5e139f'.hex_to_bin )
IERC721_ENUMERABLE     = Interface.new( 'ERC721_ENUMERABLE', '0x780e9d63'.hex_to_bin )

interfaces = [
  IERC165,       ## supportsInterface
  IERC20,        ##  token interface
  IERC721,       ##  (non-fungible) token interface
  IERC721_METADATA,   ##  (non-fungible) token interface / metadata
  IERC721_ENUMERABLE, ##  (non-fungible) token interface / enumerable
]

##
## todo - auto-add convenience helpers e.g  - why? why not?
##  - supportsERC165(account)
##  - supportsERC20(account)
##  - supportsERC721(account)
##  - ...



interfaces.each do |interface|
  puts "==> supportsInterface( #{interface.name} - 0x#{interface.id.hexdigest} )..."
  pp  c.supportsInterface( interface.id )
end

puts "bye"

