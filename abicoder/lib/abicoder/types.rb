module ABI


#######
## for now use (get inspired)
##    by the type names used by abi coder in rust
##      see  https://github.com/rust-ethereum/ethabi/blob/master/ethabi/src/param_type/param_type.rs


class Type

  def self.parse( type )   ## convenience helper
    Parser.parse( type )
  end

    ##
    # Get the static size of a type, or nil if dynamic.
    #
    # @return [Integer, NilClass]  size of static type, or nil for dynamic type
    #
  def size
    ## check/todo: what error to raise for not implemented / method not defined???
    raise ArgumentError, "no required size method defined for Type subclass #{self.class.name}; sorry"
  end
  def dynamic?() size.nil?; end

  def format
    ## check/todo: what error to raise for not implemented / method not defined???
    raise ArgumentError, "no required format method defined for Type subclass #{self.class.name}; sorry"
  end

  ####
  ##   default implementation
  ##    assume equal if class match (e.g. Address == Address)
  ##    - use format string for generic compare - why? why not?
end



class Address < Type
   def size() 32; end  ## note: address is always 20 bytes;  BUT uses 32 bytes (with padding)
   def format() 'address'; end
   def ==(another_type)  another_type.kind_of?( Address ); end
end  # class Address

class Bytes < Type
   def size() nil; end    ## note: dynamic (not known at compile-time)
   def format() 'bytes'; end
   def ==(another_type)  another_type.kind_of?( Bytes ); end
end  # class Bytes

class FixedBytes < Type
  attr_reader :length
  def initialize( length )
    @length = length   # in bytes (1,2,...32)
  end
  def size()  32; end   ## note: always uses 32 bytes (with padding)
  def format() "bytes#{@length}"; end
  def ==(another_type)
     another_type.kind_of?( FixedBytes ) && @length == another_type.length
  end
end  # class FixedBytes

class Int < Type
   attr_reader :bits
   def initialize( bits=256 )
     @bits = bits  # in bits (8,16,...256)
   end
   def size() 32;  end   ## note: always uses 32 bytes (with padding)
   def format() "int#{@bits}"; end
   def ==(another_type)
      another_type.kind_of?( Int ) && @bits == another_type.bits
   end
end  # class Int

class  Uint < Type
  attr_reader :bits
  def initialize( bits=256 )
    @bits = bits  # in bits (8,16,...256)
  end
  def size() 32;  end   ## note: always uses 32 bytes (with padding)
  def format() "uint#{@bits}"; end
  def ==(another_type)
      another_type.kind_of?( Uint ) && @bits == another_type.bits
  end
end  # class  Uint

class Bool < Type
  def size() 32;  end   ## note: always uses 32 bytes (with padding)
  def format() 'bool'; end
  def ==(another_type)  another_type.kind_of?( Bool ); end
end  # class Bool

class String < Type
  def size() nil; end    ## note: dynamic (not known at compile-time)
  def format() 'string'; end
  def ==(another_type)  another_type.kind_of?( String ); end
end  # class String

class Array < Type
  attr_reader :subtype
  def initialize( subtype )
    @subtype = subtype
  end
  def size() nil; end    ## note: dynamic (not known at compile-time)
  def format() "#{@subtype.format}[]"; end
  def ==(another_type)
    another_type.kind_of?( Array ) && @subtype == another_type.subtype
  end
end  # class Array

class FixedArray < Type
  attr_reader :subtype
  attr_reader :dim
  def initialize( subtype, dim )
    @subtype = subtype
    @dim      = dim
  end

  def size
     @subtype.dynamic? ? nil : @dim * subtype.size
  end
  def format() "#{@subtype.format}[#{@dim}]"; end
  def ==(another_type)
      another_type.kind_of?( FixedArray ) &&
        @dim == another_type.dim &&
        @subtype == another_type.subtype
  end
end  # class FixedArray

class Tuple < Type
  attr_reader :types

  def initialize( types )
    @types = types
  end

  def size
    s = 0
    @types.each do |type|
      ts = type.size
      return nil   if ts.nil?
      s += ts
    end
    s
  end
  def format
    "(#{@types.map {|t| t.format }.join(',')})"  ## rebuild minimal string
  end
  def ==(another_type)
    another_type.kind_of?( Tuple ) && @types == another_type.types
  end
end  # class Tuple
end  # module ABI

