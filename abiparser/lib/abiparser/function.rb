module ABI
class Function

  def self.parse( o )
    ## todo/fix: assert type  function (or contructor) ??
    name    = o['name']
    inputs  = o['inputs'].map {|param| Param.parse( param ) }
    outputs = o['outputs'].map {|param| Param.parse( param ) }

    payable  = nil
    constant = nil
    pure     = nil




    ## old soliditity before v0.6
    payable = o['payable']    if o.has_key?( 'payable')
    constant = o['constant']  if o.has_key?( 'constant')

    ## check - assert "strict" abi version keys - why? why not?
    if o.has_key?( 'stateMutability' ) && (o.has_key?( 'payable') || o.has_key?( 'constant'))
      puts "!! WARN:  ABI version mismatch? got stateMutability AND (payable AND/OR constant):"
      pp o
    end


    ##  newer version uses stateMutability
    if o.has_key?( 'stateMutability' )
      case o[ 'stateMutability' ]
      when 'nonpayable'    ## default
        payable  = false
        constant = false
      when 'payable'
        payable  = true
        constant = false
      when 'view'
        payable  = false
        constant = true
      when 'pure'
        payable  = false
        constant = true
        pure     = true
      else
         pp o
         ## todo/fix: change to ParseError
         raise ArgumentError, "unexpected stateMutability value; got: #{ o[ 'stateMutability' ]}"
      end
    end



    new( name, inputs: inputs, outputs: outputs,
         payable: payable,
         constant: constant,
         pure: pure )
  end


  attr_reader :name,
              :inputs, :outputs
              ##  :input_types, :output_types

  def initialize( name,
                  inputs:  [],
                  outputs: [],
                  payable: false,
                  constant: false,
                  pure: false )
     @name    = name
     @inputs  = inputs
     @outputs = outputs
     @payable = payable
     @constant = constant
     @pure = pure

     ##  parse inputs & outputs into types
     ##    note: use "calculated" sig(nature) and NOT the type
     ##        (differs for tuples, that is, types with components !!!)
     ## @input_types  = @inputs.map do |param|
     ##                                Type.parse( param.sig )
     ##                            end
     ## @output_types = @outputs.map do |param|
     ##                                  ## pp param
     ##                                  ## puts "sig: #{param.sig}"
     ##                                 Type.parse( param.sig )
     ##                             end
  end


  def constant?() @constant; end
  alias_method :readonly?, :constant?

  def payable?() @payable; end
  def pure?() @pure; end


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

  def sighash
    keccak256( sig )[0,4].hexdigest
  end



def types
    ## for debugging / analytics return all used types (input+output)
    @inputs.map {|param| param.type } +
    @outputs.map {|param| param.type }
end

end  ## class Function
end  ## module ABI

