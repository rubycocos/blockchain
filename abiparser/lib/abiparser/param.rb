module ABI
class Param

    attr_reader :type, :name

    def self.parse( o )
      type = o['type']
      name = o['name']
      new( type, name )
    end

    def initialize( type, name )  ## note: type goes first!!!
      @type = type
      @name = name
    end

    def sig
      buf = "#{@type}"
      buf
    end

    def doc
        buf = ''
        buf << "#{@type} "
        buf <<  (@name.empty? ?  '_' : @name)
        buf
    end

    def decl
      buf = ''
      buf << "#{@type} "
      buf <<  (@name.empty? ?  '_' : @name)
      buf
    end
end  ## class Param
end  ## module ABI
