# encoding: utf-8


##
# convenience wrapper for array holding blocks (that is, a blockchain)

module BlockchainLite


class Blockchain
  extend Forwardable

  def initialize( chain=[] )
    @chain = chain    # "wrap" passed in blockchain (in array)
  end

  ##
  #  todo/check: can we make it work without "virtual" block_class method
  ##    e.g. use constant lookup with singleton class or something - possible?
  def block_class() Block; end    # if not configured; fallback to "top level" Block



  ## delegate some methods (and operators) to chain array (for easier/shortcut access)
  def_delegators :@chain, :[], :size, :each, :last, :empty?, :any?


  def <<( arg )
    if arg.is_a?( block_class )
      b = arg
    else
      if arg.is_a?( Array )   ## assume its (just) data
        data = arg
      else  ## fallback; assume single transaction record; wrap in array - allow fallback - why? why not??
        data = [arg]
      end

      if @chain.empty?
        b = block_class.first( data )
      else
        bl = @chain.last
        b  = block_class.next( bl, data )
      end
    end

    @chain << b   ## add/append (new) block to chain
  end


  def broken?
    ## check for validation conventions
    ##   - start with first block?
    ##   - or start with last block (reversve)? -why? why not??

    @chain.size.times do |i|
      ###puts "checking block #{i+1}/#{@chain.size}..."

      current = @chain[i]

      if i==0   ### special case for first (genesis) block; has no previous/parent block
        if current.index != 0
          ## raise error -- invalid index!!!
          return true
        end
        if current.previous_hash != '0'
          ## raise error -- invalid previous hash (hash checksums MUST match)
          return true
        end
      else
        previous = @chain[i-1]

        if current.index != previous.index+1
          ## raise error -- invalid index!!!
          puts "!!! blockchain corrupt - block ##{current.index}: index must be a sequence (with +1 steps)"
          return true
        end

        if current.previous_hash != previous.hash
          ## raise error -- invalid previous hash (hash checksums MUST match)
          puts "!!! blockchain corrupt - block ##{current.index}: previous_hash and hash in previous block must match"
          return true
        end
      end

      if current.hash != current.calc_hash    ## (re)calc / double-check hash
        ## raise error -- invalid hash (hash checksums MUST match)
        puts "!!! blockchain corrupt - block ##{current.index}: calc_hash and hash must match; block corrupt - cannot recalculate hash"
        return true
      end
    end # loop times

    false   ## chain OK -- chain is NOT broken if we get here
  end  # method broken?

  def valid?() !broken?; end

end   ## class Blockchain

end   ## module BlockchainLite
