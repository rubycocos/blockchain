module ABI
class Param
    attr_reader :type, :name, :internal_type

    def self.parse( o )
      type          = o['type']
      internal_type = o['internalType']
      name          = o['name']

      new( type, name,
             internal_type: internal_type )
    end

    ### check - find a "better" name for internal_type
    ##            use a keyword param - why? why not?
    def initialize( type, name=nil,
                    internal_type: nil )  ## note: type goes first!!!
      @type          = type
      ## note: convert empty string "" to nil - why? why not?
      @name          = if name && name.empty?
                             nil
                       else
                          name
                       end
      @internal_type = if internal_type && internal_type.empty?
                              nil
                       else
                          internal_type
                       end
    end


    def sig
      buf = "#{@type}"
      buf
    end

    def doc
        buf = ''
        if @internal_type && @internal_type != @type
          buf << "#{@internal_type} "
        else
          buf << "#{@type} "
        end
        buf <<  (@name ?  @name : '_')
        buf
    end

    def decl
      buf = ''
      buf << "#{@type} "
      buf <<  (@name ? @name :  '_')
      ## use inline comment - why? why not?
      if @internal_type && @internal_type != @type
         buf << " /* #{@internal_type} */"
      end
      buf
    end


end  ## class Param
end  ## module ABI
