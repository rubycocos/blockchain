module ABI
class Type

class ParseError < StandardError; end


## nested inside Type - why? why not?
class Parser

   TUPLE_TYPE_RX = /^\((.*)\)
                    ((\[[0-9]*\])*)
                  /x

  def self.parse( type )
        if type =~ TUPLE_TYPE_RX
             types   = _parse_tuple_type( $1 )
             dims    = _parse_dims( $2 )

             parsed_types = types.map{ |t| parse( t ) }

             return _parse_array_type( Tuple.new( parsed_types ), dims )
        end

       base, sub, dims = _parse_base_type( type )

       _validate_base_type( base, sub )

       subtype =  case base
                  when 'string'  then   String.new
                  when 'bytes'   then   sub ? FixedBytes.new( sub ) : Bytes.new
                  when 'uint'    then   Uint.new( sub )
                  when 'int'     then   Int.new( sub )
                  when 'address' then   Address.new
                  when 'bool'    then   Bool.new
                  else
                    ## puts "  type: >#{type}<"
                    raise ParseError, "Unrecognized type base: #{base}"
                  end

       _parse_array_type( subtype, dims )
  end

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

  def self._parse_array_type( subtype, dims )
     ##
     ## todo/check - double check if the order in reverse
     ##                  in solidity / abi encoding / decoding?
     ##
    dims.each do |dim|
      subtype = if dim == -1
                     Array.new( subtype )
                else
                     FixedArray.new( subtype, dim )
                end
    end

    subtype
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



    def self._parse_tuple_type( str )
      ## note: types assumes string WITHOUT enclosing () e.g.
      ##  tuple(string,string,bool)  =>  expected as "string,string,bool"

      depth     = 0
      collected = []
      current   = ''

      ### todo/fix: replace with a simple parser!!!
      ##    allow  () and move verbose tuple() too!!!
      str.each_char do |c|
          case c
          when ',' then
            if depth == 0
              collected << current
              current = ''
            else
              current += c
            end
          when '(' then
            depth += 1
            current += c
          when ')' then
            depth -= 1
            current += c
          else
            current += c
          end
      end
      collected << current unless current.empty?

      collected
    end

end # class Parser
end  #  class Type
end  # module ABI

