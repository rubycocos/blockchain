# encoding: utf-8

module Base32
class Electrologica < Base  ## Base32  (2^5 - 5-bits)

  ALPHABET = %w[ 00 01 02 03 04 05 06 07
                 08 09 10 11 12 13 14 15
                 16 17 18 19 20 21 22 23
                 24 25 26 27 28 29 30 31 ]

  def self.alphabet() ALPHABET; end    ## add alpha / char aliases - why? why not?


  NUMBER = {
    '00' => 0,  '0' => 0,
    '01' => 1,  '1' => 1,
    '02' => 2,  '2' => 2,
    '03' => 3,  '3' => 3,
    '04' => 4,  '4' => 4,
    '05' => 5,  '5' => 5,
    '06' => 6,  '6' => 6,
    '07' => 7,  '7' => 7,
    '08' => 8,  '8' => 8,
    '09' => 9,  '9' => 9,
    '10' => 10,
    '11' => 11,
    '12' => 12,
    '13' => 13,
    '14' => 14,
    '15' => 15,
    '16' => 16,
    '17' => 17,
    '18' => 18,
    '19' => 19,
    '20' => 20,
    '21' => 21,
    '22' => 22,
    '23' => 23,
    '24' => 24,
    '25' => 25,
    '26' => 26,
    '27' => 27,
    '28' => 28,
    '29' => 29,
    '30' => 30,
    '31' => 31,
  }

  def self.number() NUMBER; end

  BINARY = _build_binary()
  CODE   = _build_code()

  ## add shortcuts (convenience) aliases
  BIN = BINARY
  NUM = NUMBER

  def self.code() CODE; end
  def self.binary() BINARY; end



  # Converts a base10 integer to a base32 string.
  def self._encode( bytes )
    bytes.each_with_index.reduce(String.new) do |buf, (byte,i)|
      buf << "-"    if i > 0   ## add separator (-) EXCEPT for first char
      buf << alphabet[byte]
      buf
    end
  end

  def self._fmt( str, group: 4, sep: ' ' )
    ## todo/fix: check sep - MUST be space () or slash (/) for now!!!!!

    str = _clean( str )

    ## format in groups of four (4) separated by space
    ##  e.g.  09-09-09-09-06-07-07-04-01-01-14-01-09-15-14-14-00-05-05-00
    ##     :  09-09-09-09 06-07-07-04 01-01-14-01 09-15-14-14 00-05-05-00

    ## note: use reverse - if not divided by four that leading slice gets cut short
    str.split('-').reverse.each_slice( group ).map { |slice| slice.reverse.join( '-' ) }.reverse.join( sep )
  end


  # Converts a base32 string to a base10 integer.
  def self._decode( str )
    str = _clean( str )
    str.split('-').reduce([]) do |bytes,char|
      byte = number[char]
      raise ArgumentError, "Value passed not a valid base32 string - >#{char}< not found in alphabet"  if byte.nil?
      bytes << byte
      bytes
    end
  end

  def self._clean( str )
    ## note: allow spaces or slash (/) for dashes (-)
    str = str.strip  ## remove leading and trailing spaces (first)
    str = str.tr( ' /', '-' )
    str = str.gsub( /-{2,}/, '-' )  ## fold more than one dash into one
  end

end # class Electrologica
end # module Base32
