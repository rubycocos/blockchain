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
    _, base, sub, dimension = BASE_TYPE_RX.match( str ).to_a

    dims = dimension.scan( /\[[0-9]*\]/ )
    if dims.join != dimension
      raise ParseError, "Unknown characters found in array declaration"
    end

    dims = dims.map {|x| x[1...-1].to_i }

    [base, sub, dims]
  end


  def self._validate_base_type( base, sub )
    case base
    when 'string'
      # note: string can not have any suffix
      raise ParseError, "String cannot have suffix" unless sub.empty?
    when 'bytes'
      raise ParseError, "Maximum 32 bytes for fixed-length bytes" unless sub.empty? || sub.to_i <= 32
    when 'uint', 'int'
      raise ParseError, "Integer type must have numerical suffix" unless sub =~ /\A[0-9]+\z/

      size = sub.to_i
      raise ParseError, "Integer size out of bounds" unless size >= 8 && size <= 256
      raise ParseError, "Integer size must be multiple of 8" unless size % 8 == 0
    when 'address'
      raise ParseError, "Address cannot have suffix" unless sub.empty?
    when 'bool'
      raise ParseError, "Bool cannot have suffix" unless sub.empty?
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
              dims  = $2.scan( /\[[0-9]*\]/ )
              dims  = dims.map {|x| x[1...-1].to_i}
          return Tuple._parse( types, dims )
        end


       base, sub, dims = _parse_base_type( type )

       _validate_base_type( base, sub )

       new( base, sub, dims )
      end


      def self.size_type
        @size_type ||= new( 'uint', '256' )
      end


    attr :base, :sub, :dims

    ##
    # @param base [String] base name of type, e.g. uint for uint256[4]
    # @param sub  [String] subscript of type, e.g. 256 for uint256[4]
    # @param dims [Array[Integer]] dimensions of array type, e.g. [1,2,0]
    #   for uint256[1][2][], [] for non-array type
    #
    def initialize( base, sub, dims=[] )
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
               if @dims.empty?
                  if ['string','bytes'].include?( @base ) && @sub.empty?
                    nil
                  else
                    32
                  end
                else
                  if @dims.last == 0    # note: 0 used for dynamic array []
                    nil
                  else
                    subtype.dynamic? ? nil : @dims.last * subtype.size
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
      buf = "#{@base}"
      buf << @sub  unless @sub.empty?
      buf << (@dims.map {|dim| dim==0 ? '[]' : "[#{dim}]"}.join)   unless @dims.empty?
      buf
    end
end   # class Type
end  # module ABI
