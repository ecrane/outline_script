require "test_helper"

class LStringTest < Minitest::Test
  
  # def setup
  #   @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  # end

  def test_literal_string_construction
    e = OutlineScript::Expr::LString.new( nil )
    assert e
    refute e.value
  end

  def test_literal_string_construction_with_token
    token = '"test"'
    e = OutlineScript::Expr::LString.new( token )
    assert e
    assert_equal "test", e.value
  end

  def test_literal_string_construction_with_token_leading_space
    token = '" space"'
    e = OutlineScript::Expr::LString.new( token )
    assert e
    assert_equal " space", e.value
  end

  def test_is_string
    assert OutlineScript::Expr::LString.is_string?( '"one"' )
    assert OutlineScript::Expr::LString.is_string?( '" two"' )
    refute OutlineScript::Expr::LString.is_string?( "1" )
  end
  
end
