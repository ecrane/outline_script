require "test_helper"

class ObjTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  end

  def test_obj_creation
    o = OutlineScript::Core::Obj.new
    assert o
  end

  
end
