require 'test_helper'

class LBooleanTest < Minitest::Test

  # def setup
  #   @engine = Gloo::App::Engine.new( [ '--quiet' ] )
  # end

  def test_literal_boolean_construction
    e = Gloo::Expr::LBoolean.new( nil )
    assert e
    assert_equal false, e.value
  end

  def test_literal_boolean_construction_with_token
    e = Gloo::Expr::LBoolean.new( true )
    assert_equal true, e.value
    e = Gloo::Expr::LBoolean.new( false )
    assert_equal false, e.value
  end

  def test_is_boolean
    assert Gloo::Expr::LBoolean.is_boolean?( true )
    assert Gloo::Expr::LBoolean.is_boolean?( false )
    refute Gloo::Expr::LBoolean.is_boolean?( 'a' )
  end

end
