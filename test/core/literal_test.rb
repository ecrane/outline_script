require "test_helper"

class LiteralTest < Minitest::Test
  
  # def setup
  #   @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  #   @engine.start
  # end

  def test_literal_constrution
    o = OutlineScript::Core::Literal.new( "string" )
    assert o
    assert_equal "string", o.value

    o = OutlineScript::Core::Literal.new( 77 )
    assert o
    assert_equal 77, o.value
  end
    
end