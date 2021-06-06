

module ECC
class Point

  ## convenience helpers - field operations
  def self.add( *nums )   ## note: for convenience allow additions of more than two numbers
    sum = nums.shift   ## "pop" first item from array
    nums.reduce( sum ) {|sum, num| curve.f.add( sum, num ) }
  end
  def self.sub( *nums )
    sum = nums.shift   ## "pop" first item from array
    nums.reduce( sum ) {|sum, num| curve.f.sub( sum, num ) }
  end
  def self.mul( a, b )         curve.f.mul( a, b );   end
  def self.pow( a, exponent )  curve.f.pow( a, exponent ); end
  def self.div( a, b )         curve.f.div( a, b );  end

  def self.on_curve?( x, y )
    ## y**2 == x**3 + curve.a*x + curve.b
    pow( y, 2 ) == add( pow( x, 3),
                        mul( curve.a, x ),
                        curve.b )
  end


  def self.[]( *args )
    new( *args )
  end

  def self.infinity  ## convenience helper / shortcut for infinity - in use anywhere? keep? why? why not?
    new( :infinity )
  end



  ## convenience helpers
  def curve() self.class.curve; end
  ## convenience helpers - field operations
  def _add( *nums )       self.class.add( *nums ); end
  def _sub( *nums )       self.class.sub( *nums ); end
  def _mul( a, b )        self.class.mul( a, b );   end
  def _pow( a, exponent ) self.class.pow( a, exponent ); end
  def _div( a, b )        self.class.div( a, b );  end



  attr_reader :x, :y

  def initialize( *args )
    ## allow :infinity or :inf for infinity for now - add more? why? why not?
    if args.size == 1 && [:inf, :infinity].include?( args[0] )
      @x = nil
      @y = nil
    elsif args.size == 2 &&
          args[0].is_a?( Integer ) &&
          args[1].is_a?( Integer )
      @x, @y = args
      raise ArgumentError, "point (#{@x}/#{@y}) is NOT on the curve"  unless self.class.on_curve?( @x, @y )
    else
      raise ArgumentError, "expected two integer numbers or :inf/:infinity; got #{args.inspect}"
    end
  end


  def infinity?
    @x.nil? && @y.nil?
  end

  def inspect
    if infinity?
      "#{self.class.name}(:infinity)"
    else
      "#{self.class.name}(#{@x},#{@y})"
    end
  end


  def curve?( other )  ## check for matching curver
    self.curve == other.curve
  end

  def require_curve!( other )
    raise ArgumentError, "cannot operate on different curves; expected #{self.class.curve} got #{other.class.curve}"  unless curve?( other )
  end


  def ==( other )
    if other.is_a?( Point ) && curve?( other )
      @x == other.x && @y == other.y
    else
      false
    end
  end


  def coerce(other)
    args = [self, other]
    ## puts " coerce(#{other} <#{other.class.name}>):"
    ## pp args
    args
  end

  def mul( coefficient )  ## note: for rmul-style to work needs coerce method to swap s*p to p*s!!
    raise ArgumentError, "integer expected for mul; got #{other.class.name}"  unless coefficient.is_a?( Integer )
    ## todo/check/fix: check for negative integer e.g. -1 etc.


    ## puts "mul( #{coefficient} <#{coefficient.class.name}>)"
=begin
    result = self.class.new( nil, nil )
    coefficient.times do
      result += self
    end
    result
=end

    coef = coefficient
    current = self
    result = self.class.new( :infinity )
    while coef > 0
      result += current   if coef.odd?   ##  if (coef & 0b1) > 0
      current = current.double   ## double the point
      coef >>= 1           ## bit shift to the right
    end
    result
  end
  alias_method :*, :mul


  def add( other )
    require_curve!( other )

    return other   if infinity?        ## self is infinity/infinity ?
    return self    if other.infinity?  ## other is infinity/infinity ?

    if @x == other.x && @y != other.y
      return self.class.new( :infinity )
    end


    if @x != other.x   ## e.g. add point operation
      # s = (other.y - @y) / (other.x - @x)
      # x3 = s**2 - @x - other.x
      # y3 = s * (@x - x3) - @y
      s  = _div( _sub(other.y, @y),
                 _sub(other.x, @x))
      x3 = _sub( _pow(s,2), @x, other.x )
      y3 = _sub( _mul( s, _sub(@x, x3)), @y )

      return self.class.new( x3, y3 )
    end

    if @x == other.x && @y == other.y   ## e.g. double point operation
      return double
    end

    raise "failed to add point #{inspect} to #{other.inspect} - no point addition rules matched; sorry"
  end
  alias_method :+, :add


  def double  # double point operation
    if @y == _mul( 0, @x )
      self.class.new( :infinity )
    else
      # s = (3 * @x**2 + curve.a) / (2 * @y)
      # x3 = s**2 - 2 * @x
      # y3 = s * (@x - x3) - @y
      s = _div( _add( _mul( 3,_pow(@x, 2)), curve.a),
                _mul(2, @y))
      x3 = _sub( _pow(s, 2), _mul( 2, @x))
      y3 = _sub( _mul( s, _sub(@x, x3)), @y)

      self.class.new( x3, y3 )
    end
  end
end # class Point
end # module ECC
