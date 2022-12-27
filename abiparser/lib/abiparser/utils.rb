module ABI
module Helpers


  SIGHASH_RX = /\A
                (0x)?
                (?<sighash>[0-9a-f]{8})
                \z/ix

  def support?( selectors, sig )
    if sig.is_a?( Interface )
      iface = sig
      iface.selectors.each do |sighash|
          unless selectors.include?( sighash )
            puts "  sighash >#{sighash}< not found in interface"
            return false
          end
      end
      true
    else
      sighash =  if m=SIGHASH_RX.match( sig )
                  m[:sighash].downcase  ## assume it's sighash (hexstring)
                 else
                  ## for convenience allow (white)spaces; auto-strip - why? why not?
                  sig = sig.gsub( /[ \r\t\n]/, '' )
                  keccak256( sig )[0,4].hexdigest
                 end

      selectors.include?( sighash ) ? true : false
    end
  end
end  # module Helpers


module Utils
  extend Helpers
  ## e.g. Utils.supports?( selectors, sig ) etc.
end

end  # module ABI