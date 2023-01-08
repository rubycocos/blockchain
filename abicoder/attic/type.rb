
class Type

 BASE_TYPE_RX = /([a-z]*)
                  ([0-9]*x?[0-9]*)
                  (
                     (\[[0-9]*\])*
                  )/x



  def self.parse( type )
    # ...

    case base
    when ''
      return parse 'address'
    # ...
    when 'fixed', 'ufixed'
      raise ParseError, "Fixed type must have suffix of form <high>x<low>, e.g. 128x128" unless sub =~ /\A[0-9]+x[0-9]+\z/

      high, low = sub.split('x').map(&:to_i)
      total = high + low

      raise ParseError, "Fixed size out of bounds (max 32 bytes)" unless total >= 8 && total <= 256
      raise ParseError, "Fixed high size must be multiple of 8" unless high % 8 == 0
      raise ParseError, "Low sizes must be 0 to 80" unless low>0 && low<=80
    when 'hash'
      raise ParseError, "Hash type must have numerical suffix" unless sub =~ /\A[0-9]+\z/

    # ...
  end
end  # class Type