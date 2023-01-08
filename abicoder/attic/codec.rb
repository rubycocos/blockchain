
   def encode_primitive_type(type, arg)


   when 'ufixed'
    high, low = type.sub.split('x').map(&:to_i)

    raise ValueOutOfBounds, arg unless arg >= 0 && arg < 2**high
    Utils.zpad_int((arg * 2**low).to_i)
  when 'fixed'
    high, low = type.sub.split('x').map(&:to_i)

    raise ValueOutOfBounds, arg unless arg >= -2**(high - 1) && arg < 2**(high - 1)

    i = (arg * 2**low).to_i
    Utils.zpad_int(i % 2**(high+low))

#...
    when 'hash'
      size = type.sub.to_i
      raise EncodingError, "too long: #{arg}" unless size > 0 && size <= 32

      if arg.is_a?(Integer)
        Utils.zpad_int(arg)
      elsif arg.size == size
        Utils.zpad arg, 32
      elsif arg.size == size * 2
        Utils.zpad_hex arg
      else
        raise EncodingError, "Could not parse hash: #{arg}"
      end
# ...
    end