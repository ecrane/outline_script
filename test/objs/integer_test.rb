require "test_helper"

class IntegerTest < Minitest::Test
  
  # def setup
  #   @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  # end

  def test_the_typename
    assert_equal "integer", OutlineScript::Objs::Integer.typename
  end


end
