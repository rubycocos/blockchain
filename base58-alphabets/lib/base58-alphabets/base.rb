#########
#  shared code for formats / variants with single char alphabets
#    e.g. Bitcoin, Flickr, ...

module Base58
class Base

  BASE = 58    #  ALPHABET.length == 58   ## 58 chars/letters/digits

  ## check if it is a hex (string)
  ##  - allow optiona 0x or 0X  and allow abcdef and ABCDEF
  HEX_RE = /\A(?:0x)?[0-9a-f]+\z/i



  # Converts a base10 integer to a base58 string.
  def self.encode_num( num )   ## num_to_base58 / int_to_base58
    _bytes( num ).reduce( String.new ) do |buf, byte|
      buf << alphabet[byte]
      buf
    end
  end


  # Converts binary string into its Base58 representation.
  # If string is empty returns an empty string.
  def self.encode_bin( data )   ## todo/check: add alias such as bin_to_base58 / data_to_base58 - why? why not?
    leading_zeroes = 0
    num = 0
    base = 1
    data.bytes.reverse_each do |byte|
        if byte == 0
          leading_zeroes += 1
        else
          leading_zeroes = 0
          num += base*byte
        end
        base *= 256
    end

    (alphabet[0]*leading_zeroes) + encode_num( num )
  end


  # Converts hex string into its Base58 representation.
  def self.encode_hex( str )
    ## todo/check: allow empty string ("") - why? why not?
    raise ArgumentError, "expected hex string (0-9a-f) - got >#{str}< - can't pack string; sorry"   unless str =~ HEX_RE || str.empty?

    str = _strip0x( str )  ##  check if input starts with 0x or 0X if yes - (auto-)cut off!!!!!
    encode_bin( [str].pack('H*') )
  end




  # Converts a base58 string to a base10 integer.
  def self.decode_num( str )     ## todo/check: add alias base58_to_num / base58_to_int
    bytes = str.each_char.reduce([]) do |bytes,char|
                 byte = number[char]
                 raise ArgumentError, "Value passed not a valid base58 string - >#{char}< not found in alphabet"  if byte.nil?
                 bytes << byte
                 bytes
            end
    _pack( bytes )
  end


  def self.decode_bin( str )
    num = decode_num( str )

    ## use base 256 for characters to binary conversion!!!
    data = _bytes( num, base: 256 ).pack( 'C*' )

    ## check for leading zeros
    str.bytes.each do |byte|
      break if byte != alphabet[0].ord
      data = "\x00" + data
    end
    data
  end

  def self.decode_hex( str )
    decode_bin( str ).unpack( 'H*' )[0]
  end




  ####
  # (private) helper - note: leading underscore in name e.g. _bytes
  def self._bytes( num, base: BASE )   ## num_to_bytes
    ## note: 0 leads to empty []  and NOT [0] !!!!
    b = []
    while num > 0
      num, mod = num.divmod( base )
      b << mod
    end
    b = b.reverse
    b
  end


  def self._pack( bytes )   ## bytes_to_num
    num = 0
    bytes.reverse.each_with_index do |byte,index|
      num += byte * (BASE**(index))
    end
    num
  end


  def self._strip0x( str )    ## todo/check: add alias e.g. strip_hex_prefix or such - why? why not?
    (str[0,2] == '0x' || str[0,2] == '0X') ?  str[2..-1] : str
  end


end # class Base
end # module Base58
