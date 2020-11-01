# encoding: utf-8

require 'digest'    # for hash checksum digest function SHA256
require 'pp'        # for pp => pretty printer

## require 'date'
## require 'time'
## require 'json'
## require 'uri'



## our own code
require 'merkletree/version'    # note: let version always go first


class MerkleTree

  class Node
    attr_reader :value
    attr_reader :left
    attr_reader :right

    def initialize( value, left, right )
       @value = value
       @left  = left
       @right = right
    end


    ####
    ## for debugging / testing add pretty printing (dump tree)
    def dump() do_dump( 0 ); end

    def do_dump( depth )    ## dump (recursive_worker)
      depth.times { print ' ' }
      print "#{depth}:[#{value}] "
      if @left
        print '{'
        puts
        @left.do_dump( depth+1 )
        @right.do_dump( depth+1)  if @right    # note: make right node optional (might be nil/empty)
        depth.times { print ' ' }
        print '}'
      end
      puts
    end # do_dump

  end # class Node


  ## convenience helpers
  def self.for( *args )
     if args.size == 1 && args[0].is_a?( Array )
        transactions = args[0]   ## "unwrap" array in array
     else
        transactions = args      ## use "auto-wrapped" splat array
     end
     ## for now use to_s for calculation hash
     hashes = transactions.map { |tx| calc_hash( tx.to_s ) }
     self.new( hashes )
  end

  def self.compute_root_for( *args )
    if args.size == 1 && args[0].is_a?( Array )
       transactions = args[0]   ## "unwrap" array in array
    else
       transactions = args      ## use "auto-wrapped" splat array
    end

    ## for now use to_s for calculation hash
    hashes = transactions.map { |tx| calc_hash( tx.to_s ) }
    self.compute_root( hashes )
  end



  attr_reader :root
  attr_reader :leaves

  def initialize( *args )
    if args.size == 1 && args[0].is_a?( Array )
       hashes = args[0]   ## "unwrap" array in array
    else
       hashes = args      ## use "auto-wrapped" splat array
    end

    @hashes = hashes
    @root   = build_tree
  end


  def build_tree
    level = @leaves = @hashes.map { |hash| Node.new( hash, nil, nil ) }

    ## todo/fix: handle hashes.size == 0 case
    ##   - throw exception - why? why not?
    ##   -  return empty node with hash '0' - why? why not?

    if @hashes.size == 1
      level[0]
    else
      ## while there's more than one hash in the layer, keep looping...
      while level.size > 1
        ## loop through hashes two at a time
        level = level.each_slice(2).map do |left, right|
          ## note: handle special case
          # if number of nodes is odd e.g. 3,5,7,etc.
          #   last right node is nil  --  duplicate node value for hash
          ##   todo/check - duplicate just hash? or add right node ref too - why? why not?
          right = left   if right.nil?

          Node.new( MerkleTree.calc_hash( left.value + right.value ), left, right)
        end
        ## debug output
        ## puts "current merkle hash level (#{level.size} nodes):"
        ## pp level
      end
      ### finally we end up with a single hash
      level[0]
    end
  end  # method build tree




  ### shortcut/convenience -  compute root hash w/o building tree nodes
  def self.compute_root( *args )
    if args.size == 1 && args[0].is_a?( Array )
       hashes = args[0]   ## "unwrap" array in array
    else
       hashes = args      ## use "auto-wrapped" splat array
    end

    ## todo/fix: handle hashes.size == 0 case
    ##   - throw exception - why? why not?
    ##   -  return empty node with hash '0' - why? why not?

    if hashes.size == 1
      hashes[0]
    else
      ## while there's more than one hash in the list, keep looping...
      while hashes.size > 1
        # if number of hashes is odd e.g. 3,5,7,etc., duplicate last hash in list
        hashes << hashes[-1]   if hashes.size % 2 != 0

        ## loop through hashes two at a time
        hashes = hashes.each_slice(2).map do |left,right|
           ## join both hashes slice[0]+slice[1] together
           hash = calc_hash( left + right )
        end
      end

      ## debug output
      ## puts "current merkle hashes (#{hashes.size}):"
      ## pp hashes
      ### finally we end up with a single hash
      hashes[0]
    end
  end # method compute_root


  def self.calc_hash( data )
    sha = Digest::SHA256.new
    sha.update( data )
    sha.hexdigest
  end


end # class MerkleTree


# say hello
puts MerkleTree.banner    if defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG
