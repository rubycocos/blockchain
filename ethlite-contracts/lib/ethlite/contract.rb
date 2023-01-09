

module Ethlite

class Contract


def self.at( address )
    puts "   creating new contract #{self.name} @ #{address}"
    new( address )
end


def self.sig( name, inputs: [], outputs: [] )
  @methods ||= {}
  @methods[ name ] = ContractMethod.new( name,
                                         inputs: inputs,
                                         outputs: outputs )
  @methods
end
def self.methods()
   @methods ||= {}
   @methods
end



def self.address( address )
  @address = address
  @address
end

def self.default_address()
  defined?( @address ) ? @address : nil
end

def initialize( address = self.class.default_address )
  @address = address
end


def do_call( name, *args )
   puts "==> calling #{self.class.name}##{name} with args:"
   pp args
   method = self.class.methods[ name ]
   ## pp m
   method.do_call( Ethlite.config.rpc, @address, args )
end

end   ## class Contract


end  ##  module Ethlite