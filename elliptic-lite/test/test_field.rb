###
#  to run use
#     ruby -I ./lib -I ./test test/test_field.rb


require 'helper'

class TestField < MiniTest::Test

## same as F13 = FiniteField.new(13) - use shortcut - why? why not?
class F₁₃ < ECC::FiniteField::Element
  def self.prime() 13; end
end


def test_f13
  pp F₁₃
  pp F₁₃.prime
  assert_equal 13, F₁₃.prime

  assert F₁₃.include?( 0 )
  assert F₁₃.include?( 12 )
  assert_equal false, F₁₃.include?( 13 )


  pp F₁₃.new(7)
  pp F₁₃.new(6)

  a = F₁₃[7]
  b = F₁₃[6]

  assert_equal false, a == b
  assert_equal false, F₁₃[7] == F₁₃[6]

  assert a == a
  assert F₁₃[7] == F₁₃[7]



  a = F₁₃[7]
  b = F₁₃[12]
  c = F₁₃[6]

  assert_equal c, a+b
  assert_equal 6, F₁₃.add( 7, 12 )

  c = F₁₃[8]
  assert_equal c, a-b
  assert_equal F₁₃[8], a-b
  assert_equal 8, F₁₃.sub( 7, 12 )

  a = F₁₃[3]
  b = F₁₃[12]
  c = F₁₃[10]

  assert_equal c, a*b
  assert_equal F₁₃[10], F₁₃[3]*F₁₃[12]
  assert_equal 10, F₁₃.mul( 3, 12 )


  a = F₁₃[3]
  b = F₁₃[1]
  assert_equal b, a**3
  assert_equal b, a*a*a
  assert_equal a**3, a*a*a
  assert_equal 1, F₁₃.pow( 3, 3 )

  a = F₁₃[7]
  b = F₁₃[8]

  pp a**-3
  assert_equal b, a**-3
  assert_equal 8, F₁₃.pow( 7, -3 )
end



class F₁₇ < ECC::FiniteField::Element
  def self.prime() 17; end
end

def test_f17
  pp F₁₇.new(7)
  assert F₁₇.new(7) == F₁₇[7]
  assert F₁₇.new(7) == F₁₇.new(7)
  assert F₁₇[7] == F₁₇[7]
end


F₁₉ = ECC::FiniteField.new(19)

def test_f19
   a = F₁₉[2]
   b = F₁₉[7]
   c = a / b

   assert_equal F₁₉[3], c

   assert_equal F₁₉[9], F₁₉[7] / F₁₉[5]
   assert_equal 9, F₁₉.div( 7, 5 )
end


def test_examples
   a = F₁₃[7]
   b = F₁₃[12]
   c = F₁₃[6]
   assert_equal c, a+b

   c = F₁₃[8]
   assert_equal c, a-b

   a = F₁₃[3]
   b = F₁₃[12]
   c = F₁₃[10]
   assert_equal c, a*b

   a = F₁₃[3]
   b = F₁₃[1]
   assert_equal b, a**3
   assert_equal b, a*a*a
   assert_equal a**3, a*a*a

   a = F₁₉[2]
   b = F₁₉[7]
   c = F₁₉[3]
   assert_equal c, a/b


   assert_equal F₁₃[6],  F₁₃[7] + F₁₃[12]
   assert_equal F₁₃[8],  F₁₃[7] - F₁₃[12]
   assert_equal F₁₃[10], F₁₃[3] * F₁₃[12]
   assert_equal F₁₃[1],  F₁₃[3] ** 3
   assert_equal F₁₃[1],  F₁₃[3] * F₁₃[3] * F₁₃[3]
   assert_equal F₁₃[3] * F₁₃[3] * F₁₃[3], F₁₃[3] ** 3

   assert_equal F₁₉[3],  F₁₉[2] / F₁₉[7]
end

end # class TestField


