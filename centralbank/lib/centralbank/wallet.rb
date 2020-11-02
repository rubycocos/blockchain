###########
#  Single Address Wallet

class Wallet
  attr_reader :address

  def initialize( address )
    @address = address
  end

  def generate_transaction( to, amount )
    Tx.new( address, to, amount )
  end

end  # class Wallet
