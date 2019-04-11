require "test_helper"

class ContainerTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal "container", OutlineScript::Objs::Container.typename
  end

  def test_the_short_typename
    assert_equal "can", OutlineScript::Objs::Container.short_typename
  end

  def test_find_type
    assert @dic.find_obj( "container" )
    assert @dic.find_obj( "CONTAINER" )
    assert @dic.find_obj( "can" )
    assert @dic.find_obj( "CAN" )
  end


end
