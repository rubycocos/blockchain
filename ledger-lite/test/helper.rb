## $:.unshift(File.dirname(__FILE__))

## minitest setup

require 'minitest/autorun'


## our own code

require 'ledger-lite/base'     ## note: use "modular" version without "top-level" Ledger constant



## some helper classes for testing

module V1
class Transaction

  attr_reader :from, :to, :amount

  #####
  # flexible for testing - allows:
  #  Tx.new( 'Alice', 'Bob', 12 )
  #  Tx.new( from: 'Alice', to: 'Bob', amount: 12 )

  def initialize( *args, **kwargs )
    if args.empty? # try keyword args
      @from   = kwargs[:from]
      @to     = kwargs[:to]
      @amount = kwargs[:amount]
    else           # try positional args
      @from   = args[0]
      @to     = args[1]
      @amount = args[2]
    end
  end

end # class Transaction

  Tx     = Transaction      ## convenience shortcut
  Ledger = LedgerLite::Ledger
end # module V1



module V2
class Transaction

  attr_reader :from, :to, :qty, :name

  #####
  # flexible for testing - allows:
  #  Tx.new( 'Alice', 'Bob', 12, 'Tulip Semper Augustus' )
  #  Tx.new( from: 'Alice', to: 'Bob', qty: 12, name: 'Semper Augustus' )

  def initialize( *args, **kwargs )
    if args.empty? # try keyword args
      @from   = kwargs[:from]
      @to     = kwargs[:to]
      @qty    = kwargs[:qty]
      @name   = kwargs[:name]
    else           # try positional args
      @from   = args[0]
      @to     = args[1]
      @qty    = args[2]
      @name   = args[3]
    end
  end

end # class Transaction

  Tx     = Transaction      ## convenience shortcut
  Ledger = LedgerLite::V2::Ledger
end # module V2




class Block
  def initialize( *transactions )
    @transactions = transactions
  end

  def transactions
    @transactions
  end
end  # class Block
