require "test_helper"

class UntypedTest < Minitest::Test
  
  # def setup
  #   @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  # end

  def test_the_typename
    assert_equal "untyped", OutlineScript::Objs::Untyped.typename
  end


end
