# encoding: utf-8


##
# ruby version inspired by
#    Block Parsers: How to Read the Bitcoin Block Chain (in Python)
#      by Alex Gorale on December 2014
#    https://www.cryptocoinsnews.com/block-parser-how-read-bitcoin-block-chain/
#
#   see https://github.com/tenthirtyone/blocktools
#
#  alternatives:
##   see https://github.com/toidi/pyblockchain
#        https://github.com/petertodd/python-bitcoinlib
#        https://github.com/lian/bitcoin-ruby


#
# todo/fix:
#    use   from_raw or from_binary( )   !!!!!
#


###
# add magicnums for networks e.g.
# class Network(Enum):
#
#    Reference:
#    https://github.com/bitcoin/bitcoin/blob/master/src/chainparams.cpp
#
#    mainnet = 0xd9b4bef9
#    testnet = 0x0709110b
#    testnet2= ??  etc.
#    regtest = 0xdab5bffa

#
#  add find_magicnum loop for magicnum first byte only see
#  Block.parse = function*(stream) {
#
#
#    var findMagicNumber = function*(stream, octet) {
#        while (octet !== 0xf9) {
#            octet = yield stream.readByte();
#        }
#        octet = yield stream.readByte();
#        if (octet !== 0xbe) {
#            return findMagicNumber(stream, octet);
#        }
#        octet = yield stream.readByte();
#        if (octet !== 0xb4) {
#            return findMagicNumber(stream, octet);
#        }
#        octet = yield stream.readByte();
#        if (octet !== 0xd9) {
#            return findMagicNumber(stream, octet);
#        }
#    };
## see https://curiosity-driven.org/low-level-bitcoin
##
#
#
#  add to ruby samples
#    see https://github.com/grant-olson/blockwalker/blob/master/lib/blockwalker/block.rb
#        https://github.com/grant-olson/blockwalker/blob/master/lib/blockwalker/readers.rb


require 'pp'
require 'date'
require 'time'


def uint1( f )
  bytes = f.read(1)
  bytes[0].ord      ## todo: use unpack too for single byte
end

def uint2( f )
	 bytes = f.read(2)
   bytes.unpack('H')[0]
end

def uint4( f )
  bytes = f.read(4)
  bytes.unpack('I')[0]
end

def uint8( f )
	bytes = f.read(8)
  bytes.unpack('Q')[0]
end


def hash32( f )
  bytes = f.read(32)
  bytes.reverse    # note: reverse bytes (in python [::-1])
end


def varint( f )
	size = uint1( f )
  puts '[debug] varint: size=%d 0x%02x' % [size,size]

	return size         if size < 0xfd
	return uint2( f )	  if size == 0xfd
	return uint4( f )	  if size == 0xfe
	return uint8( f )	  if size == 0xff    ## 0xff == 255
	return -1
end



def hash_str( bytes )
  buf = ""         ### todo: check if there's a ruby hex version or something
  bytes.each_byte { |b| buf << '%02x' % b }
  buf
end



class Tx
	def initialize( f )
		@version   = uint4( f )
		@in_count  = varint( f )
    puts "[debug] Tx.initialize: @in_count=#{@in_count}"
		@inputs = []
    if @in_count > 0
		  @in_count.times do
			  @inputs << TxInput.new( f )
      end
    end

    @out_count  = varint( f )
    puts "[debug] Tx.initialize: @out_count=#{@out_count}"
		@outputs = []
		if @out_count > 0
			@out_count.times do
				@outputs << TxOutput.new( f )
      end
    end
		@lock_time = uint4( f )
  end

	def dump
		puts
		puts "========== New Transaction =========="
		puts "Tx Version: %d" % @version
		puts "Inputs:     %d" % @in_count
		@inputs.each do |i|
			i.dump
    end

		puts "Outputs:    %d" % @out_count
		@outputs.each do |o|
			o.dump
    end
		puts "Lock Time:  %d" % @lock_time
  end
end ## class Tx


class TxInput
	def initialize( f )
		@prev_hash    = hash32( f )
		@tx_out_id    = uint4( f )
		@script_len   = varint( f )
    puts "[debug] TxInput.initialize: @script_len=#{@script_len}"

    ## returns uint8 !!! e.g.
    ##   72340941654327295   -- too big to read!!!!  check if varint is working for 0xff ???

    @script_sig   = f.read( @script_len )
		@seq_no       = uint4( f )
  end

	def dump
		puts "  Previous Hash:  %s"  % hash_str( @prev_hash )
		puts "  Tx Out Index:   %8x" % @tx_out_id
		puts "  Script Length:  %d"  % @script_len
		puts "  Script Sig:     %s"  % hash_str( @script_sig )
		puts "  Sequence:       %8x" % @seq_no
  end
end # class TxInput


class TxOutput
	def initialize( f )
		@value      = uint8( f )
		@script_len = varint( f )
    puts "[debug] TxOutput.initialize: @script_len=#{@script_len}"

    ## returns 0 is possible for script_len ???.
  	@pubkey     = @script_len > 0 ? f.read( @script_len ) : ''
  end

	def dump
		puts "  Value:       %d" % @value
		puts "  Script Len:  %d" % @script_len
		puts "  Pubkey:      %s" % hash_str( @pubkey )
  end
end # class TxOutput


class BlockHeader
	def initialize( f )       ## (always fixed) 80 bytes = 4 + 32 + 32 + 4 + 4 + 4
		@version       = uint4( f )
		@previous_hash = hash32( f )
		@merkle_hash   = hash32( f )
		@time          = uint4( f )
		@bits          = uint4( f )
		@nonce         = uint4( f )
  end

  def dump
		puts "Version:      %d"  % @version
		puts "Previous Hash %s"  % hash_str( @previous_hash )
		puts "Merkle Root   %s"  % hash_str( @merkle_hash )
		puts "Time          %s  (%s) " % [@time.to_s, Time.at(@time).utc.to_datetime.to_s]
		puts "Difficulty    %8x" % @bits
		puts "Nonce         %s"  % @nonce
  end
end  # class BlockHeader



class Block
	def initialize( f )
		@continue_parsing = true
		@magicnum = 0
		@blocksize = 0
		@blockheader = ''
		@tx_count = 0
		@txs = []

		if find_magicnum( f )
      if has_length?( f, @blocksize )
  			@blockheader = BlockHeader.new( f )
  			@tx_count = varint( f )
        puts "[debug] Block.initialize: @tx_count #{@tx_count}"
  			@txs = []
        @tx_count.times do
          @txs << Tx.new( f )
        end
  		else
        @continue_parsing = false
      end
		else
      @continue_parsing = false
    end
  end

  def find_magicnum( f )
    loop do
      if has_length?( f, 8 )
        @magicnum  = uint4(f)
        @blocksize = uint4(f)

        puts "[debug] Block.initialize: @magicnum #{@magicnum}, @blocksize #{@blocksize}"
        if [0xdab5bffa].include?( @magicnum )
          return true
        else
           puts "!!! magic number mismatch - block must start with magic number; rescanning @ #{f.pos}..."
           exit 0   ## exit for now
        end
      else
        return false
      end
    end
  end # find_magicnum

  def has_length?( f, size )
		pos = f.pos
		f.seek( 0, File::SEEK_END )
		fsize = f.pos   ## file size

		f.seek( pos )   ## restore pos

		temp_block_size = fsize - pos

    temp_block_size < size ? false : true
  end

  def continue_parsing?() @continue_parsing; end

  def dump
		puts
		puts "Magic No:  %8x" % @magicnum
		puts "Blocksize: %d"  % @blocksize
		puts
		puts "########## Block Header ##########"
		@blockheader.dump
		puts
		puts "##### Tx Count: %d" % @tx_count
		@txs.each do |tx|
		  tx.dump
    end
  end

end # class Block




def parse( f )
  puts "parsing blockhain..."

  f.seek( 0, File::SEEK_END )
  fsize = f.pos - 80   ## Minus last Block header size for partial file

  f.seek(0, 0)

  counter = 0
  continue_parsing = true

	while continue_parsing do
		block = Block.new( f )
		continue_parsing = block.continue_parsing?
		if continue_parsing
      puts
      puts "..:: Block ##{counter} ::.."    # note: start counting w/ block 0
			block.dump
    end
		counter += 1

    ## break if counter > 3
  end

	puts
	puts 'Reached End of Field'
	puts 'Parsed %s blocks' % counter
end # method parse



if __FILE__ == $0
  if ARGV.size == 0
    path = './regtest/blocks/blk00000.dat'
  else
    path = ARGV[0]
  end

  f = File.open( path, 'rb' )
  parse( f )
  f.close
end
