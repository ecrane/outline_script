require "test_helper"

class ContainerTest < Minitest::Test
  
  # def setup
  #   @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  # end

  def test_the_typename
    assert_equal "container", OutlineScript::Objs::Container.typename
  end


end
