require "test_helper"

class ObjRefTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  end

  def test_obj_ref_constrution
    o = OutlineScript::Core::ObjRef.new( nil )
    assert o
    refute o.raw

    o = OutlineScript::Core::ObjRef.new( "" )
    assert o
    assert o.raw
  end

  def test_root_reference
    o = OutlineScript::Core::ObjRef.root
    assert o
    assert_equal "root", o.raw
  end  
  
end
