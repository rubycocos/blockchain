module ABI
class Param
    attr_reader :type, :name,
                :internal_type,
                :components

    def self.parse( o )
      type          = o['type']
      internal_type = o['internalType']
      name          = o['name']
      components    = o['components'] ? o['components'].map { |c| parse( c ) } : nil
      indexed       = o['indexed']

      new( type, name,
             internal_type: internal_type,
             components: components,
             indexed: indexed )
    end

    ### check - find a "better" name for internal_type
    ##            use a keyword param - why? why not?
    def initialize( type, name=nil,
                     internal_type: nil,
                     components: nil,
                      indexed: nil  )  ## note: type goes first!!!
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
      @components  = components
      @indexed = indexed   ## note: only used for event params (create a subparam type - why? why not??)
    end



    def sig
      @sig ||= begin
                  if @components
                     ## replace tuple with  (type,...)
                     ##  e.g.  tuple[] becomes (type,...)[] etc.
                     tuple = @components.map {|c| c.sig }.join(',')
                     @type.sub( "tuple", "(#{tuple})" )
                  else
                    "#{@type}"
                  end
               end
      @sig
    end


    def doc
        buf = ''
        if @internal_type && @internal_type != sig
          buf << "#{@internal_type} "
        else
          buf << "#{sig} "
        end
        buf <<  (@name ?  @name : '_')
        buf
    end

end  ## class Param
end  ## module ABI
