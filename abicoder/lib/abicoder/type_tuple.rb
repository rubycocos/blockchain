module ABI


class Tuple < Type

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


    ## note:  use Type.parse NOT Tuple._parse
    ##           to parse Tuple!!!
    def self._parse( tuple, dims=[] )
      ## puts "  enter Tuple.parse( types: >#{tuple.inspect}<, dims: >#{dims.inspect}< )"

      # e.g.
      #=>   enter Tuple.parse( types: >"string,string,bool"<, dims: >[]< )
      types        = _parse_tuple_type( tuple )
      parsed_types = types.map{ |t| Type.parse( t ) }

      Tuple.new( parsed_types, dims )
    end



    attr_reader :types

    def initialize( types, dims=[] )
      super( 'tuple', '', dims )
      @types = types

      ## puts "tuple:"
      ## pp self
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
      if @dims.empty?
        s = 0
        @types.each do |type|
          ts = type.size
          return nil if ts.nil?
          s += ts
        end
        s
      else
        if @dims.last == 0     # note:  0 used for dynamic array []
          nil
        else
          subtype.dynamic? ? nil : @dims.last * subtype.size
        end
      end
    end

    def subtype
      @subtype ||= Tuple.new( types, dims[0...-1] )
    end

    def format
      ## rebuild minimal string
      buf = "(#{@types.map {|t| t.format }.join(',')})"
    end


end  # class Tuple
end  ## module ABI
