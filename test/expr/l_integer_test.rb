require "test_helper"

class LIntegerTest < Minitest::Test
  
  # def setup
  #   @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  # end

  def test_literal_integer_construction
    e = OutlineScript::Expr::LInteger.new( nil )
    assert e
    assert_equal 0, e.value
  end

  def test_literal_integer_construction_with_token
    token = 23
    e = OutlineScript::Expr::LInteger.new( token )
    assert e
    assert_equal 23, e.value
  end

  def test_is_integer
    assert OutlineScript::Expr::LInteger.is_integer?( "23" )
    refute OutlineScript::Expr::LInteger.is_integer?( "a" )
  end

end
