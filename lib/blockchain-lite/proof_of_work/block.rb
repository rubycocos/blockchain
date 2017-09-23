# encoding: utf-8

module BlockchainLite
  module ProofOfWork


class Block

  attr_reader :index
  attr_reader :timestamp
  attr_reader :data
  attr_reader :previous_hash
  attr_reader :nonce        ## proof of work if hash starts with leading zeros (00)
  attr_reader :hash

  def initialize(index, data, previous_hash)
    @index         = index
    @timestamp     = Time.now.utc    ## note: use coordinated universal time (utc)
    @data          = data
    @previous_hash = previous_hash
    @nonce, @hash  = compute_hash_with_proof_of_work
  end

  def calc_hash
    sha = Digest::SHA256.new
    sha.update( @nonce.to_s + @index.to_s + @timestamp.to_s + @data + @previous_hash )
    sha.hexdigest
  end


  def self.first( data='Genesis' )    # create genesis (big bang! first) block
    ## uses index zero (0) and arbitrary previous_hash ('0')
    Block.new( 0, data, '0' )
  end

  def self.next( previous, data='Transaction Data...' )
    Block.new( previous.index+1, data, previous.hash )
  end

private

  def compute_hash_with_proof_of_work( difficulty='00' )
    nonce = 0
    loop do
      hash = calc_hash_with_nonce( nonce )
      if hash.start_with?( difficulty )
        return [nonce,hash]    ## bingo! proof of work if hash starts with leading zeros (00)
      else
        nonce += 1             ## keep trying (and trying and trying)
      end
    end
  end

  def calc_hash_with_nonce( nonce=0 )
    sha = Digest::SHA256.new
    sha.update( nonce.to_s + @index.to_s + @timestamp.to_s + @data + @previous_hash )
    sha.hexdigest
  end

end  # class Block


end  ##  module ProofOfWork
end  ##  module BlockchainLite
