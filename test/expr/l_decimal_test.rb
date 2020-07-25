require 'test_helper'

class LDecimalTest < Minitest::Test

  # def setup
  #   @engine = Gloo::App::Engine.new( [ '--quiet' ] )
  # end

  def test_literal_integer_construction
    e = Gloo::Expr::LDecimal.new( nil )
    assert e
    assert_equal 0.0, e.value
  end

  def test_literal_integer_construction_with_token
    token = 31.7
    e = Gloo::Expr::LDecimal.new( token )
    assert e
    assert_equal 31.7, e.value
  end

  def test_is_decimal
    assert Gloo::Expr::LDecimal.decimal?( '23.2' )
    assert Gloo::Expr::LDecimal.decimal?( '0.0' )
    assert Gloo::Expr::LDecimal.decimal?( '-1.23' )
    assert Gloo::Expr::LDecimal.decimal?( '0.009' )

    refute Gloo::Expr::LDecimal.decimal?( 'a' )
    refute Gloo::Expr::LDecimal.decimal?( '1' )
    refute Gloo::Expr::LDecimal.decimal?( '0' )
  end

end
