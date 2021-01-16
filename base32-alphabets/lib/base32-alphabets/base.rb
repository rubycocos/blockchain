# encoding: utf-8

#########
## shared code for formats / variants with single char alphabets
##   e.g. Kai, Crockford, ...

module Base32
class Base

  def self.bytes( num_or_str )
    if num_or_str.is_a? String
      str   = num_or_str
      bytes = _decode( str )
    else  # assume number
      num   = num_or_str
      bytes = Base32._bytes( num )
    end
  end


  # Converts a base10 integer to a base32 string.
  def self.encode( num_or_bytes )
    if num_or_bytes.is_a? Array
      bytes = num_or_bytes
    else
      num = num_or_bytes
      bytes = Base32._bytes( num )
    end
    _encode( bytes )
  end

  def self._encode( bytes )
    bytes.reduce( String.new ) do |buf, byte|
      buf << alphabet[byte]
      buf
    end
  end

  def self.fmt( str_or_num_or_bytes, group: 4, sep: ' ' )
    if str_or_num_or_bytes.is_a? String
      str = str_or_num_or_bytes
    else  ## assume number (Integer) or bytes (Array)
      num_or_bytes = str_or_num_or_bytes
      str = encode( num_or_bytes )   ## auto-encode (shortcut)
    end
    _fmt( str, group: group, sep: sep )
  end

  def self._fmt( str, group: 4, sep: ' ' )
    str = _clean( str )

    ## format in groups of four (4) separated by space
    ##  e.g.  ccac7787fa7fafaa16467755f9ee444467667366cccceede
    ##     :  ccac 7787 fa7f afaa 1646 7755 f9ee 4444 6766 7366 cccc eede
    str.reverse.gsub( /(.{#{group}})/, "\\1#{sep}" ).reverse.sub( /^#{sep}/, '' )
  end


  # Converts a base32 string to a base10 integer.
  def self.decode( str_or_bytes )
    if str_or_bytes.is_a? Array
      bytes = str_or_bytes
    else  ## assume string
      str   = str_or_bytes
      bytes = _decode( str )
    end
    Base32._pack( bytes )
  end


  def self._decode( str )
    str = _clean( str )
    str.each_char.reduce([]) do |bytes,char|
      byte = number[char]
      raise ArgumentError, "Value passed not a valid base32 string - >#{char}< not found in alphabet"  if byte.nil?
      bytes << byte
      bytes
    end
  end

  def self._clean( str )
    ## note: remove space ( ), dash (-), slash (/) for now as "allowed / supported" separators
    str.tr( ' -/', '' )
  end



  ########################
  ## (private) helpers
  def self._build_binary
    ## e.g. '00000', '00001', '00010', '00011', etc.
    number.reduce({}) do |h, (char,index)|
      h[char]        = '%05b' % index
      h
    end
  end

  def self._build_code
    ## e.g. '00', '01', '02', '03', '04', etc.
    number.reduce({}) do |h, (char,index)|
      h[char]        = '%02d' % index
      h
    end
  end

end # class Base
end # module Base32
