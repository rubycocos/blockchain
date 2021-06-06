

module ECC

class FiniteField

###################
#  meta-programming "macro" - build class (on the fly)
#
#   todo/check:  rename max to modulus or prime or ?? - why? why not?
#   todo/check:  memoize generated classes ( do NOT regenerate duplicates) - why? why not?
def self.build_class( prime )
  klass = Class.new( Element )

  klass.class_eval( <<RUBY )
  def self.prime
     #{prime}
  end
RUBY

  klass
end

class << self
  alias_method :old_new, :new           # note: store "old" orginal version of new
  alias_method :new,     :build_class   #   replace original version with build_class
end



class Element   ## FiniteFiledElement base class
  ###
  # base functionality
  attr_reader :num


  def self.include?( num )
     num >=0 && num < prime
  end

  def self.add( a, b )  ## note: assumes integer as arguments values
    ( a + b ) % prime
  end

  def self.sub( a, b )
    ( a - b ) % prime
  end

  def self.mul( a, b )
    ( a * b ) % prime
  end

  def self.pow( a, exponent )
    n = exponent % ( prime - 1 )   # note: make possible negative exponent ALWAYS positive
    a.pow( n, prime ) % prime
  end

  def self.div( a, b )
    # use Fermat's little theorem:
    #      self.num ** (prime-1) % prime == 1
    #  this means:
    #      1/num == num.pow( prime-2, prime )
    ( a * b.pow( prime-2, prime )) % prime
  end



  def self.[]( num )
    new( num )
  end



  def initialize( num )
    raise ArgumentError, "number #{num} not in finite field range 0 to #{self.class.prime}"   unless self.class.include?( num )

    @num  = num
    self.freeze   ## make "immutable"
    self
  end

  def prime() self.class.prime; end   ## convenience helper

  def inspect
    "#{self.class.name}(#{@num})"
  end



  def prime?( other )  ## check for matching prime
    self.class.prime == other.class.prime
  end

  def require_prime!( other )
    raise ArgumentError, "cannot operate on different finite fields; expected #{self.class.prime} got #{other.class.prime}"  unless prime?( other )
  end


  def ==(other)
    if other.is_a?( Element ) && prime?( other )
      @num == other.num
    else
      false
    end
  end

  def add( other )
    require_prime!( other )

    num = self.class.add( @num, other.num )
    self.class.new( num )
  end

  def sub( other )
    require_prime!( other )

    num = self.class.sub( @num, other.num )
    self.class.new( num )
  end

  def mul( other )
    require_prime!( other )

    num = self.class.mul( @num, other.num )
    self.class.new( num )
  end

  def pow( exponent )
    num = self.class.pow( @num, exponent )
    self.class.new( num )
  end

  def div( other )
    require_prime!( other )

    num = self.class.div( @num, other.num )
    self.class.new( num )
  end


  alias_method :+,  :add
  alias_method :-,  :sub
  alias_method :*,  :mul
  alias_method :/,  :div
  alias_method :**, :pow
end # (nested) class Element


end # class FiniteField
end # module ECC

