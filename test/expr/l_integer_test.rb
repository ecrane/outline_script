require "test_helper"

class LIntegerTest < Minitest::Test
  
  # def setup
  #   @engine = Gloo::App::Engine.new( [ "--quiet" ] )
  # end

  def test_literal_integer_construction
    e = Gloo::Expr::LInteger.new( nil )
    assert e
    assert_equal 0, e.value
  end

  def test_literal_integer_construction_with_token
    token = 23
    e = Gloo::Expr::LInteger.new( token )
    assert e
    assert_equal 23, e.value
  end

  def test_is_integer
    assert Gloo::Expr::LInteger.is_integer?( "23" )
    refute Gloo::Expr::LInteger.is_integer?( "a" )
  end

end
