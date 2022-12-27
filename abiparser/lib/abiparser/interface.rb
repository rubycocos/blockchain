
module ABI


  ## rename to QueryInterface or SupportInterface
  ##   or InterfaceType or InterfaceId or such - why? why not?
class Interface

  attr_reader :interface_id


  ##
  ## todo/fix:  make sure full function defs get passed in (not only sigs!!!)
  def initialize( *functions )
    @functions = functions
    @selectors = {}

    @functions.each do |func|
      sig = func
      sighash =  keccak256( sig )[0,4].hexdigest
      puts "0x#{sighash} => #{sig}"

      ## assert - no duplicates allowed
      if @selectors[sighash]
        puts "!! ERROR - duplicate function signature #{sig}; already in use; sorry"
        exit 1
      end

      @selectors[sighash] = sig
    end
    @interface_id = calc_interface_id
  end


  def calc_interface_id
    interface_id = nil
    @selectors.each do |sighash,_|
      sighash = sighash.hex_to_bin   ## note: convert to binary string (from hexstring)!!
      interface_id = if interface_id.nil?
        sighash   ## init with sighash
      else
        interface_id ^ sighash   ## use xor
      end
    end
    interface_id.hexdigest
  end


  ## return hexstrings of sig(natures) - why? why not?
  ## rename to sighashes - why? why not?
  def selectors()  @selectors.keys;  end

  def support?( sig )
     Utils.support?( @selectors.keys, sig )
  end
  alias_method :supports?, :support?   ## add alternate spelling - why? why not?

end  ## class Interface
end  # module ABI
