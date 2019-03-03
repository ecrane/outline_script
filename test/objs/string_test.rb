require "test_helper"

class StringTest < Minitest::Test
  
  # def setup
  #   @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  # end

  def test_the_typename
    assert_equal "string", OutlineScript::Objs::String.typename
  end


end
