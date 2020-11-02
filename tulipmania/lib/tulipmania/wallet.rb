###########
#  Single Address Wallet

class Wallet
  attr_reader :address

  def initialize( address )
    @address = address
  end

  def generate_transaction( to, qty, what )
    Tx.new( address, to, qty, what )
  end

end  # class Wallet
