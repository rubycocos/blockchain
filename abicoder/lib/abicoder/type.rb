module ABI
class Type

  class ParseError < StandardError; end

  ##
  # Crazy regexp to seperate out base type component (eg. uint), size (eg.
  # 256, 128, nil), array component (eg. [], [45], nil)
  #
  BASE_TYPE_RX = /([a-z]*)
                  ([0-9]*)
                  ((\[[0-9]*\])*)
                 /x

  def self._parse_base_type( str )
    _, base, subscript, dimension = BASE_TYPE_RX.match( str ).to_a

      ## note:  use [Integer,Integer] array in the future for sub
      ##          for fixed  (e.g. 128x128 => [128,128]) or such
      ##          for now always assume single integer (as string)
    sub = subscript == '' ? nil : subscript.to_i

    ## e.g. turn "[][1][2]" into [-1,1,2]
    ##         or ""        into  []   -- that is, empty array
    dims = _parse_dims( dimension )

    [base, sub, dims]
  end

  def self._parse_dims( str )
    dims = str.scan( /\[[0-9]*\]/ )

    ## note: return -1 for dynamic array size e.g. []
    ##        e.g. "[]"[1...-1]  => ""
    ##             "[0]"[1...-1]  => "0"
    ##             "[1]"[1...-1]  => "1"
    dims = dims.map do |dim|
                         size = dim[1...-1]
                         size == '' ? -1 : size.to_i
                    end
    dims
  end


  def self._validate_base_type( base, sub )
    case base
    when 'string'
      # note: string can not have any suffix
      raise ParseError, "String cannot have suffix"  if sub
    when 'bytes'
      raise ParseError, "Maximum 32 bytes for fixed-length bytes"  if sub && sub > 32
    when 'uint', 'int'
      raise ParseError, "Integer type must have numerical suffix"  unless sub
      raise ParseError, "Integer size out of bounds"    unless sub >= 8 && sub <= 256
      raise ParseError, "Integer size must be multiple of 8"  unless sub % 8 == 0
    when 'address'
      raise ParseError, "Address cannot have suffix"  if sub
    when 'bool'
      raise ParseError, "Bool cannot have suffix"   if sub
    else
      ## puts "  type: >#{type}<"
      raise ParseError, "Unrecognized type base: #{base}"
    end
  end


    TUPLE_TYPE_RX = /^\((.*)\)
                    ((\[[0-9]*\])*)
                  /x

  def self.parse( type )
        if type =~ TUPLE_TYPE_RX
              types = $1
              dims  = _parse_dims( $2 )

          return Tuple._parse( types, dims )
        end


       base, sub, dims = _parse_base_type( type )

       _validate_base_type( base, sub )

       new( base, sub, dims )
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
end  # module ABI
