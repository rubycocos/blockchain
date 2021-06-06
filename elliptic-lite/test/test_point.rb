###
#  to run use
#     ruby -I ./lib -I ./test test/test_point.rb


require 'helper'

class TestPoint < MiniTest::Test

  class Point_5_7 < ECC::Point
    def self.curve() @curve ||= ECC::Curve.new( a: 5, b: 7 ); end
  end

  def test_point_5_7
    p1 = Point_5_7.new( -1, -1 )   # point with x/y coords: -1/-1
    ## p2 = Point_5_7.new( -1, -2 )   # raise ArgumentError!! point NOT on curve

    assert              Point_5_7.on_curve?( -1, -1 )  #=> true
    assert_equal false, Point_5_7.on_curve?( -1, -2 )  #=> false

    inf = Point_5_7[ :infinity ]
    assert              inf.infinity?                 #=> true

    p1  = Point_5_7[-1, -1]
    p2  = Point_5_7[-1,  1]
    inf = Point_5_7[ :infinity ]

    assert Point_5_7[-1,-1],     p1  + inf
    assert Point_5_7[-1,1],      inf + p2
    assert Point_5_7[:infinity], p1  + p2

    p1 = Point_5_7[ 2, 5]
    p2 = Point_5_7[-1,-1]
    assert Point_5_7[3,-7], p1 + p2

    p1 = Point_5_7[-1,-1]
    assert Point_5_7[18,77], p1 + p1
  end



  class F₂₂₃ < ECC::FiniteField::Element
    def self.prime() 223; end
  end

  class Point_F₂₂₃0_7 < ECC::Point
    def self.curve() @curve ||= ECC::Curve.new( a: 0, b: 7, f: F₂₂₃ ); end
  end


  def test_point_f₂₂₃0_7
    p1 = Point_F₂₂₃0_7[ 192, 105 ]
    p2 = Point_F₂₂₃0_7[ 17, 56 ]
    assert Point_F₂₂₃0_7[170,142],  p1 + p2

    p1 = Point_F₂₂₃0_7[ 170, 142 ]
    p2 = Point_F₂₂₃0_7[ 60, 139 ]
    assert Point_F₂₂₃0_7[220,181], p1 + p2

    p1 = Point_F₂₂₃0_7[ 47, 71 ]
    p2 = Point_F₂₂₃0_7[ 17, 56 ]
    assert Point_F₂₂₃0_7[215,68], p1 + p2


    p    = Point_F₂₂₃0_7[ 192, 105 ]
    assert Point_F₂₂₃0_7[49,71], p+p

    p    = Point_F₂₂₃0_7[ 143, 98 ]
    assert Point_F₂₂₃0_7[64,168], p+p

    p    = Point_F₂₂₃0_7[ 47, 71 ]
    assert Point_F₂₂₃0_7[36,111], p+p
    assert Point_F₂₂₃0_7[194,51], p+p+p+p
    assert Point_F₂₂₃0_7[116,55], p+p+p+p+p+p+p+p
    assert Point_F₂₂₃0_7[:infinity], p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+p

    assert 2*p, p+p
    assert 4*p, p+p+p+p
    assert 8*p, p+p+p+p+p+p+p+p
    assert 21*p, p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+p
  end
end # class TestPoint

