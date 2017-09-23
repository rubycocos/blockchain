# encoding: utf-8

##
##  Note: Work in Progress
##    -- under construction!!!!!!
##    do NOT yet use this class

module BlockchainLite
  module Bitcoin


## bitcoin-compatible block
##  note: work-in-progress

class Block


  class Header

    attr_reader :index
    attr_reader :timestamp
    attr_reader :data
    attr_reader :previous_hash
    attr_reader :hash

    def initialize(index, data, previous_hash)
      @index         = index
      @timestamp     = Time.now.utc    ## note: use coordinated universal time (utc)
      @data          = data
      @previous_hash = previous_hash
      @hash          = calc_hash
    end

  private

    def calc_hash
      sha = Digest::SHA256.new
      sha.update( @index.to_s + @timestamp.to_s + @data + @previous_hash )
      sha.hexdigest
    end
  end  # class Header


  def self.first( data='Genesis' )    # create genesis (big bang! first) block
      ## uses index zero (0) and arbitrary previous_hash ('0')
      Block.new( 0, data, '0' )
  end

  def self.next( previous, data='Transaction Data...' )
    Block.new( previous.index+1, data, previous.hash )
  end

end  # class Block


end  ##  module Bitcoin
end  ##  module BlockchainLite
