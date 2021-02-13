
module Cryptopunks
### wrap metadata (e.g. punk types, accessories, etc.
##     in structs for easy/easier access)



class Metadata

  ## nested class
  class Type     ## todo/check: use alias family or such?
     attr_reader :name,
                 :limit
     def initialize( name, limit )
       @name  = name
       @limit = limit
     end
     ## def to_s() @name; end

     def inspect
      %Q{<Type "#{@name}", limit: #{@limit}>}
    end



     def self.build
       TYPES.reduce( {} ) do |h, rec|
          type = Type.new( rec[:name], rec[:limit ] )
          h[ rec[:name].downcase ] = type
          h
       end
     end

     def self.registry
       ## auto-build registry (hash table) lookup (by name)
       @@types ||= build
       @@types
     end

     def self.all() registry.values; end

     def self.find( q ) registry[ q.to_s.downcase ]; end
  end  ## (nested) class Type



  ## nested class
  class AccessoryType
     attr_reader :name,
                 :accessories
     def initialize( name, accessories=[] )
       @name        = name
       @accessories = accessories
     end



     def self.build
       ATTRIBUTES.reduce( {} ) do |h, rec|
         type = AccessoryType.new( rec[:name] )
         ## add all accessories
         rec[:values].each do |value|
           type.accessories << Accessory.new( value, type )
         end
         h[ rec[:name].downcase ] = type
         h
       end
     end

     def self.registry
       ## auto-build registry (hash table) lookup (by name)
       @@types ||= build
       @@types
     end

     def self.all() registry.values; end

     def self.find( q ) registry[ q.to_s.downcase ]; end
  end  ## (nested) class AccessoryType


  ## nested class
  class Accessory

   attr_reader :name,
               :type,
               :limit
   def initialize( name, type, limit=nil )
     @name  = name
     @type  = type
     @limit = limit
   end


   def inspect
     %Q{<Accessory "#{@name}", type: "#{@type.name}", limit: #{@limit}>}
   end



   def self.build
     AccessoryType.all.reduce( {} ) do |h, type|
                                      type.accessories.each do |acc|
                                        h[ acc.name.downcase ] = acc
                                      end
                                      h
                                    end
   end

   def self.registry
     ## auto-build registry (hash table) lookup (by name)
     @@types ||= build
     @@types
   end

   def self.all() registry.values; end

   def self.find( q ) registry[ q.to_s.downcase ]; end
end  ## (nested) class Accessory






  attr_reader :id,
              :type,
              :accessories,
              :birthday    ## todo/check: use minted or such?

  def initialize( id, type, accessories )
    @id          = id
    @type        = type
    @accessories = accessories
    @birthday    = Date.new( 2017, 6, 23)   ## all 10,000 minted on June 23, 2017
  end

  ## convenience helpers for types (5)
  def alien?()  @type.name=='Alien'; end
  def ape?()    @type.name=='Ape'; end
  def zombie?() @type.name=='Zombie'; end
  def female?() @type.name=='Female'; end
  def male?()   @type.name=='Male'; end
end # class Metadata

end  # module Cryptopunks
