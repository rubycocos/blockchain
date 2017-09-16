# encoding: utf-8


class Block

  attr_reader :index
  attr_reader :timestamp
  attr_reader :data
  attr_reader :previous_hash
  attr_reader :hash

  def initialize(index, timestamp, data, previous_hash)
    @index         = index
    @timestamp     = timestamp
    @data          = data
    @previous_hash = previous_hash
    @hash          = calc_hash
  end

  def self.first( data="Genesis" )    # create genesis (big bang! first) block
    ## uses index zero and arbitrary previous_hash
    Block.new( 0, Time.now, data, "0" )
  end

  def self.next( previous, data="Transaction Data..." )
    Block.new( previous.index+1, Time.now, data, previous.hash )
  end

private

  def calc_hash
    sha = Digest::SHA256.new
    sha.update @index.to_s + @timestamp.to_s + @data.to_s + @previous_hash.to_s
    sha.hexdigest
  end

end  # class Block
