#########
#  shared code for formats / variants with single char alphabets
#    e.g. Bitcoin, Flickr, ...

module Base58
class Base

  # Converts a base10 integer to a base58 string.
  def self.encode( num_or_bytes )
    if num_or_bytes.is_a?( Array )
      bytes = num_or_bytes
    else
      num = num_or_bytes
      bytes = Base58._bytes( num )
    end

    bytes.reduce( String.new ) do |buf, byte|
      buf << alphabet[byte]
      buf
    end
  end


  # Converts a base58 string to a base10 integer.
  def self.decode( str_or_bytes )
    if str_or_bytes.is_a?( Array )
      bytes = str_or_bytes
    else  ## assume string
      str   = str_or_bytes
      bytes = str.each_char.reduce([]) do |bytes,char|
                                         byte = number[char]
                                         raise ArgumentError, "Value passed not a valid base58 string - >#{char}< not found in alphabet"  if byte.nil?
                                         bytes << byte
                                         bytes
                                       end
    end
    Base58._pack( bytes )
  end

end # class Base
end # module Base58
