# encoding: utf-8


##
# convenience wrapper for array holding blocks (that is, a blockchain)


class Blockchain

  def initialize( chain=nil, block_class: nil )
    if chain.nil?
      @block_class = block_class || BlockchainLite::ProofOfWork::Block
      b0 = @block_class.first( 'Genesis' )
      @chain = [b0]
    else
      @chain = chain    # "wrap" passed in blockchain (in array)
      if block_class          # configure block class ("factory")
        @block_class = block_class
      else
        ### no block class configured; use class of first block
        ##  todo/fix: throw except if chain is empty (no class configured) - why? why not??
        @block_class = @chain.first.class    if @chain.first
      end
    end
  end


  def last() @chain.last; end     ## return last block in chain


  def <<( arg )
    if arg.is_a? String   ## assume its (just) data
      data = arg
      bl   = @chain.last
      b    = @block_class.next( bl, data )
    elsif arg.class.respond_to?( :first ) &&       ## check if respond_to? Block.first? and Block.next? - assume it's a block
          arg.class.respond_to?( :next )           ##  check/todo: use is_a? @block_class why? why not?
      b = arg
    else  ## fallback; assume its (just) data (not a block)
      data = arg.to_s    ## note: always convert arg to string!!  - why? why not??
      bl   = @chain.last
      b    = @block_class.next( bl, data )
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
