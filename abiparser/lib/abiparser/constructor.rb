module ABI
class Constructor

  def self.parse( o )
      ## note:
      ##  - has no name
      ##  - has no ouptputs
      ## e.g.
      ##   {"inputs":[],
      ##    "stateMutability":"nonpayable",
      ##    "type":"constructor"}

    inputs  = o['inputs'].map {|param| Param.parse( param ) }
    payable = nil

    ## old soliditity before v0.6
    ##  newer version uses stateMutability
    if o.has_key?( 'stateMutability' )
      case o[ 'stateMutability' ]
      when 'nonpayable'    ## default
        payable  = false
      when 'payable'
        payable  = true
      else
         pp o
         ## todo/fix: change to ParseError
         raise ArgumentError, "unexpected stateMutability (constructor) value ; got: #{ o[ 'stateMutability' ]}"
      end
    end

    ## check - assert "strict" abi version keys - why? why not?
    if o.has_key?( 'stateMutability' ) && (o.has_key?( 'payable') || o.has_key?( 'constant'))
      pp o
      puts "!! WARN:  ABI version mismatch? got stateMutability AND payable OR constant"
      exit 1
    end

    if o.has_key?( 'constant')
      pp o
      puts "!! WARN: constant for constructor possible?"
      exit 1
    end

    payable = o['payable']    if o.has_key?( 'payable')

    new( inputs: inputs,  payable: payable )
  end


  attr_reader :inputs, :input_types

  def initialize( inputs: [],
                  payable: false )
     @inputs  = inputs
     @payable = payable

     ##  parse inputs into types
     ##    note: use "calculated" sig(nature) and NOT the type
     ##        (differs for tuples, that is, types with components !!!)
     @input_types  = @inputs.map {|param| Type.parse( param.sig ) }
  end


  ##  add - why? why not?
  ## def constant?() false; end
  ## alias_method :readonly?, :constant?

  def payable?() @payable; end

  def sig
    ## note: signature
    ##  only includes name and inputs
    ##   excludes / drops outputs!!!

    buf = "constructor"
    if @inputs.empty?
      buf << "()"
    else
      buf2 = @inputs.map {|param| param.sig }
      buf << "(#{buf2.join(',')})"
    end
    buf
  end


  def doc
      buf = "constructor"
      if @inputs.empty?
        buf << "()"
      else
        buf2 = @inputs.map {|param| param.doc }
        buf << "(#{buf2.join(', ')})"
      end
      buf
  end

  def decl
    buf = "constructor"
    if @inputs.empty?
      buf << "()"
    else
      buf2 = @inputs.map {|param| param.decl }
      buf << "(#{buf2.join(', ')})"
    end
    buf << ";"
    buf
  end


end  # class Constructor
end  # module ABI


