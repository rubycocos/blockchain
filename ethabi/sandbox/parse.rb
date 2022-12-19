###
#   parse and pretty print abis
#
#  to run use
#     ruby sandbox/parse.rb

require 'ethname'

require 'bytes'
require 'ethlite'


## extend String
class String
  alias_method :hexdigest, :bin_to_hex   ## note: bin_to_hex added via Bytes!!!
end  # class String


def keccak256( bin )
  Ethlite::Utils.keccak256( bin )
end

def sig( bin )
  keccak256( bin )[0,4]
end





class Function

  class Param
    def self.parse( o )
      type = o['type']
      name = o['name']
      new( type, name )
    end
    def initialize( type, name )  ## note: type goes first!!!
      @type = type
      @name = name
    end

    def doc
        buf = ''
        buf << "#{@type} "
        buf <<  (@name.empty? ?  '_' : @name)
        buf
    end
    def sig
      buf = "#{@type}"
      buf
    end
 end  ## (nested) class Param


  def self.parse( o )
    ## todo/fix: assert type  function (or contructor) ??
    name    = o['name']
    inputs  = o['inputs'].map {|param| Param.parse( param ) }
    outputs = o['outputs'].map {|param| Param.parse( param ) }

    payable = o['payable']
    constant = o['constant']

    new( name, inputs: inputs, outputs: outputs )
  end

  def initialize( name, inputs: [], outputs: [] )
     @name    = name
     @inputs  = inputs
     @outputs = outputs
  end


  def sig
    ## note: signature
    ##  only includes name and inputs
    ##   excludes / drops outputs!!!

    buf = "#{@name}"
    if @inputs.empty?
      buf << "()"
    else
      buf2 = @inputs.map {|param| param.sig }
      buf << "(#{buf2.join(',')})"
    end
    buf
 end


  def doc
      buf = "#{@name}"
      if @inputs.empty?
        buf << "()"
      else
        buf2 = @inputs.map {|param| param.doc }
        buf << "(#{buf2.join(', ')})"
      end
      buf << " returns "
      if @outputs.empty?
        buf << "()"
      else
        buf2 = @outputs.map {|param| param.doc }
        buf << "(#{buf2.join(', ')})"
      end
      buf
  end
end




##
##  todo
##    sort / group functions by
##      constant / view
##      payable  (last)



def pretty_print( abi )
  buf = ''
  abi.each do |o|
     if o['type'] == 'function'
        func = Function.parse( o )
        buf << "- function #{func.doc}\n"
        buf << "  - sig #{func.sig}  =>  0x#{sig(func.sig).hexdigest}\n"
     elsif o['type'] == 'constructor'
     elsif o['type'] == 'event'
     else
       pp o
       raise TypeError, "expected function or event; sorry: got #{o['type']}"
     end
    end
  buf
end


paths = Dir.glob( "./abis/*.json" )
paths[0..3].each do |path|
  abi = read_json( path )
  pp abi
  basename = File.basename( path, File.extname( path ))

  buf = "# Contract ABI - #{basename}\n\n"
  buf <<  pretty_print( abi )
  puts  buf

  write_text( "./abis/#{basename}.md", buf )
end




puts "bye"
