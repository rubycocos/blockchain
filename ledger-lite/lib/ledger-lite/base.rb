# encoding: utf-8

require 'pp'            # for pp => pretty printer
require 'forwardable'




## our own code
require 'ledger-lite/version'    # note: let version always go first



module LedgerLite



class Configuration

  ## system settings

  ##  use a different name e.g.
  ##  -  mint  (like royal mint or federal coin mint?) or
  ##  -  base
  ##  -  magic  (for creating coins out-of-nothing?) or
  ##  -  network or ??) - why? why not?
  ##
  attr_accessor :coinbase

  ##  note: for now is an array (allow/ support multiple coinbases)
  ##  note: add a (†) coinbase  marker
  COINBASE = ['Coinbase†']

  def initialize
    @coinbase = COINBASE
  end

  def coinbase?( addr )
    @coinbase.include?( addr )
  end
end # class Configuration




class Base
  extend Forwardable


  ## lets you use
  ##   Ledger.configure do |config|
  ##      config.coinbase = ['Keukenhof†']
  ##   end

  def self.configure
    yield( config )
  end

  def self.config
    @config ||= Configuration.new
  end



  attr_reader :addr     ## make addr private e.g. remove - why? e.g. use hash forwards/delegates - why not?


  ## delegate some methods (and operators) to addr hash (for easier/shortcut access)
  def_delegators :@addr, :[], :size, :each, :empty?, :any?


  def initialize( *args )
    @addr = {}

     ## add all transactions passed in on startup; if no args - do nothing
     unless args.empty?
       ## note: MUST unsplat (*) args
       ##   otherwise args get "double" wrapped in array
       write( *args )
     end
  end # method initialize



  def write( *args )
    puts "write:"
    pp args

    ##  note: allow/support splat-* for now for convenience (auto-wraps args into array)
    if args.size == 1 && args[0].is_a?( Array )
      puts " unwrap array in array"
      blks_or_txns = args[0]   ## "unwrap" array in array
    elsif args.size == 1 && defined?( Blockchain ) && args[0].is_a?( Blockchain )
      ## support passing in of "top-level" defined blockchain class if defined
      ##  pass along all blocks ("unwrapped" from blockchain)
      blks_or_txns = []
      args[0].each { |b| blks_or_txns << b }
    else
      blks_or_txns = args      ## use "auto-wrapped" splat array
    end

    ## "unpack" transactions from possible (optional) blocks
    ##   and return "flattend" **single** array of transactions
    transactions = unpack_transactions( blks_or_txns )

    ## unpack & unsplat array (to pass in args to send) => from, to, amount
    transactions.each { |tx| send( *unpack(tx) ) }
  end

  ## note: add and the << operator is an alias for write
  alias :add :write
  alias :<<  :write


  def unpack_transactions( blocks )
    ## "unpack" transactions from possible (optional) blocks
    ##   and return "flattend" **single** array of transactions

    blocks.reduce( [] ) do |acc, block|
      if block.respond_to?( :transactions )   ## bingo! assume it's block if it has transactions method
        acc + block.transactions
      else   ## note: otherwise assumes it's just a "plain" **single** transaction
        tx = block
        acc + [tx]    ## wrap in array (use acc << tx  - with side effects/mutate in place - why? why not?)
      end
    end
  end
end ## class Base



class Ledger < Base

  def unpack( tx )
    ## "unpack" from, to, amount values

    puts "unpack:"
    pp tx

    if tx.is_a?( Hash )   ## support hashes
      from   = tx[:from]
      to     = tx[:to]
      amount = tx[:amount]
    else   ## assume it's a transaction (tx) struct/class
      from   = tx.from
      to     = tx.to
      amount = tx.amount
    end
    [from,to,amount]
  end


  ##
  # find a better name - why? why not?
  ##  e.g. use can? funds? sufficient? has_funds?
  def sufficient?( addr, amount )
    return true   if self.class.config.coinbase?( addr )    ## note: coinbase has unlimited funds!!!

    @addr.has_key?( addr )     &&
    @addr[addr] - amount >= 0
  end

  ## note: sufficient_funds? is an alias for sufficient?
  alias :sufficient_funds? :sufficient?


  ## apply/do single transaction - send payment - do transfer
  ##  - find a different name - why? why not?
  def send( from, to, amount )

    if sufficient?( from, amount )
      if self.class.config.coinbase?( from )
        # note: coinbase has unlimited funds!! ("virtual" built-in money printing address)
      else
         @addr[ from ] -= amount
      end
      @addr[ to ] ||= 0
      @addr[ to ] += amount
    end
  end  # method send

  ## note: transfer is an alias for send (payment)
  alias :transfer :send

end # class Ledger




module V2
   ## ledger for commodities (e.g.tulips) / assets / etc.

   class Ledger < Base

     def unpack( tx )
       ## "unpack" from, to, amount values

       puts "unpack:"
       pp tx

       if tx.is_a?( Hash )   ## support hashes
         from   = tx[:from]
         to     = tx[:to]
         qty    = tx[:qty]    ## check: use different name e.g. amount, num, etc. why? why not?
         name   = tx[:name]   ## check: use different name e.g. title, what, etc. why? why not?
       else   ## assume it's a transaction (tx) struct/class
         from   = tx.from
         to     = tx.to
         qty    = tx.qty
         name   = tx.name
       end
       [from,to,qty,name]
     end


     ##
     # find a better name - why? why not?
     def sufficient?( addr, qty, name )
       return true   if self.class.config.coinbase?( addr )    ## note: coinbase has unlimited funds!!!

       @addr.has_key?( addr ) &&
       @addr[addr].has_key?( name ) &&
       @addr[addr][name] - qty >= 0
     end


     ## apply/do single transaction - send commodity/assets - do transfer
     ##  - find a different name - why? why not?
     def send( from, to, qty, name )

       if sufficient?( from, qty, name )
         if self.class.config.coinbase?( from )
           # note: coinbase has unlimited funds!! ("virtual" built-in money printing address)
         else
            @addr[ from ][ name ] -= qty
         end
         @addr[ to ] ||= {}     ## make sure addr exists (e.g. init with empty hash {})
         @addr[ to ][ name ] ||= 0
         @addr[ to ][ name ] += qty
       end
     end  # method send

     ## note: transfer is an alias for send (payment)
     alias :transfer :send

   end # class Ledger

end # module V2



end # module LedgerLite


# say hello
puts LedgerLite.banner    if defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG
