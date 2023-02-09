module ABI
  class Event

    def self.parse( o )
      ## todo/fix: assert type  function (or contructor) ??
      name    = o['name']
      inputs  = o['inputs'].map {|param| Param.parse( param ) }

      new( name, inputs: inputs )
    end


    attr_reader :name,
                :inputs
                ##  :input_types

    def initialize( name,
                    inputs:  [] )
       @name    = name
       @inputs  = inputs
    end


    def sig
      ## note: signature
      ##  only includes name and inputs

      ##
      ##  todo/fix: check if event sig includes indexed or/and
      ##     special prefix or such!!!!

      buf = "#{@name}"
      if @inputs.empty?
        buf << "()"
      else
        params = @inputs.map {|param| param.sig }
        buf << "(#{params.join(',')})"
      end
      buf
    end

    def sighash
      keccak256( sig )[0,4].hexdigest
    end




  def types
      ## for debugging / analytics return all used types (input+output)
      @inputs.map {|param| param.type }
  end

  end  ## class Event
  end  ## module ABI

