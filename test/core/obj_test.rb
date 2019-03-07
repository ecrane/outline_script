require "test_helper"

class ObjTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  end

  def test_obj_creation
    o = OutlineScript::Core::Obj.new
    assert o
  end

  def test_default_value
    o = OutlineScript::Core::Obj.new
    assert o
    assert o.value
    assert_equal "", o.value
  end

  def test_default_container
    o = OutlineScript::Core::Obj.new
    assert o
    assert o.children
    assert_equal 0, o.children.count
  end
  
  def test_setting_value
    o = OutlineScript::Core::Obj.new
    o.value = "test"
    assert_equal "test", o.value
  end

  def test_adding_children
    o = OutlineScript::Core::Obj.new
    assert_equal 0, o.child_count
    o.add_child OutlineScript::Objs::String.new
    assert_equal 1, o.child_count
  end

  def test_has_child_check
    o = OutlineScript::Core::Obj.new
    s = OutlineScript::Objs::String.new
    s.name = "str"
    o.add_child s
    assert o.has_child?( "str" )
    refute o.has_child?( "x" )
  end

  def test_find_child
    o = OutlineScript::Core::Obj.new
    s = OutlineScript::Objs::String.new
    s.name = "str"
    refute o.find_child( "str" )
    o.add_child s
    assert_same s, o.find_child( "str" )
  end

  def test_find_nonexistant_child
    o = OutlineScript::Core::Obj.new
    refute o.find_child( "xtr" )
    s = OutlineScript::Objs::String.new
    s.name = "str"
    o.add_child s
    assert_same s, o.find_child( "str" )
    refute o.find_child( "xtr" )
    refute o.find_child( "stri" )
    refute o.find_child( "st" )
  end
  
  def test_child_count
    o = OutlineScript::Core::Obj.new
    assert_equal 0, o.child_count
    o = OutlineScript::Objs::Container.new
    assert_equal 0, o.child_count
    s = OutlineScript::Objs::String.new
    s.name = "str"
    o.add_child s
    assert_equal 1, o.child_count
  end
  
  def test_type_display
    o = OutlineScript::Objs::Container.new
    assert_equal "container", o.type_display
    s = OutlineScript::Objs::String.new
    assert_equal "string", s.type_display
  end
  
end
