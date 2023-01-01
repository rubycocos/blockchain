module ABI
class Type

    def self.parse( type )   ## convenience helper
      Parser.parse( type )
    end


    attr :base, :sub, :dims

    ##
    # @param base [String] base name of type, e.g. uint for uint256[4]
    # @param sub  [Integer] subscript of type, e.g. 256 for uint256[4]
    # @param dims [Array[Integer]] dimensions of array type, e.g. [1,2,-1]
    #   for uint256[1][2][], [] for non-array type
    #
    def initialize( base, sub=nil, dims=[] )
      ## note:  use [Integer,Integer] array in the future for sub
      ##          for fixed  (e.g. 128x128 => [128,128]) or such
      @base = base
      @sub  = sub
      @dims = dims
    end

    def ==(another_type)
       @base == another_type.base &&
       @sub == another_type.sub &&
       @dims == another_type.dims
    end

    ##
    # Get the static size of a type, or nil if dynamic.
    #
    # @return [Integer, NilClass]  size of static type, or nil for dynamic type
    #
    def size
       @size ||= calculate_size
    end

    def calculate_size
               if @dims.empty?  ## it's a primitive type
                  if ['string', 'bytes'].include?( @base ) && @sub.nil?
                    nil    ## dynamic string or bytes
                  else
                    32
                  end
               else   ## it's an array
                  if @dims.last == -1    # note: -1 used for dynamic array []
                    nil
                  else
                    if subtype.dynamic?
                       nil
                    else
                      @dims.last * subtype.size
                    end
                  end
               end
    end

    def dynamic?() size.nil?; end


    ##
    # Type with one dimension lesser.
    #
    # @example
    #   Type.parse("uint256[2][]").subtype # => Type.new('uint', '256', [2])
    #
    # @return [ABI::Type]
    #
    def subtype
      @subtype ||= Type.new( @base, @sub, @dims[0...-1] )
    end


    def format
      ## rebuild minimal type string
      buf =  "#{@base}"
      buf << "#{@sub}"  if @sub
      buf << (@dims.map {|dim| dim==-1 ? '[]' : "[#{dim}]"}.join)   unless @dims.empty?
      buf
    end
end   # class Type



class Tuple < Type

  attr_reader :types

  def initialize( types, dims=[] )
    super( 'tuple', nil, dims )
    @types = types
  end


  def ==(another_type)
    another_type.kind_of?(Tuple) &&
      @types == another_type.types  &&
      @dims  == another_type.dims
  end

  def size
    @size ||= calculate_size
  end

  def calculate_size
    if @dims.empty?     ## "plain" tuple
      s = 0
      @types.each do |type|
        ts = type.size
        return nil   if ts.nil?
        s += ts
      end
      s
    else                  ## it's an array of tuples
      if @dims.last == -1     # note:  -1 used for dynamic array []
        nil
      else
        if subtype.dynamic?
          nil
        else
          @dims.last * subtype.size
        end
      end
    end
  end

  def subtype
    @subtype ||= Tuple.new( types, dims[0...-1] )
  end

  def format
    ## rebuild minimal string
    buf = "(#{@types.map {|t| t.format }.join(',')})"
    buf
  end
end  # class Tuple
end  # module ABI
