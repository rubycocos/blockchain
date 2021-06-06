### stdlibs
require 'pp'
require 'securerandom'
require 'digest'



module ECC
class IntegerOp      ## change to IntegerFieldOp or such - why? why not?
  def self.add( a, b ) a + b;  end
  def self.sub( a, b ) a - b;  end
  def self.mul( a, b ) a * b;  end
  def self.pow( a, exponent ) a.pow( exponent ); end
  def self.div( a, b ) a / b;  end
end


class Curve
  attr_reader :a, :b, :f

  def initialize( a:, b:, f: IntegerOp ) ## field (operations type) class
    @a  = a
    @b  = b
    @f  = f
  end


  def field?( other )   ## matching field (operations type) class?
    @f == other.f
  end

  def ==(other)
    if other.is_a?( Curve ) && field?( other )
      self.a == other.a && self.b == other.b
    else
      false
    end
  end
end  # class Curve
end # module ECC



## our own code
require 'elliptic-lite/field'
require 'elliptic-lite/point'


module ECC
class Group
  attr_reader :g, :n
  ## add generator alias for g - why? why not?
  ## add order alias for n - why? why not?
  def initialize( g:, n: )
    @g, @n = g, n

    ## note: generator point (scalar multiplied by n - group order results in infinity point)
    ## pp @n*@g  #=> Point(:infinity)
  end

  ## note: get point class from generator point
  def point( *args )  @g.class.new( *args );  end
end # class Group
end # module ECC


require 'elliptic-lite/secp256k1'
require 'elliptic-lite/signature'



