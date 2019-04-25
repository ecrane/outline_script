require "test_helper"

class ObjTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ "--quiet" ] )
    @engine.start
  end

  def test_obj_creation
    o = Gloo::Core::Obj.new
    assert o
  end

  def test_default_value
    o = Gloo::Core::Obj.new
    assert o
    assert o.value
    assert_equal "", o.value
  end

  def test_default_container
    o = Gloo::Core::Obj.new
    assert o
    assert o.children
    assert_equal 0, o.children.count
  end
  
  def test_setting_value
    o = Gloo::Core::Obj.new
    o.value = "test"
    assert_equal "test", o.value
  end

  def test_adding_children
    o = Gloo::Core::Obj.new
    assert_equal 0, o.child_count
    s = Gloo::Objs::String.new
    o.add_child s
    assert_equal 1, o.child_count
    assert_equal o, s.parent
  end

  def test_has_child_check
    o = Gloo::Core::Obj.new
    s = Gloo::Objs::String.new
    s.name = "str"
    o.add_child s
    assert o.has_child?( "str" )
    refute o.has_child?( "x" )
  end

  def test_find_child
    o = Gloo::Core::Obj.new
    s = Gloo::Objs::String.new
    s.name = "str"
    refute o.find_child( "str" )
    o.add_child s
    assert_same s, o.find_child( "str" )
  end
  
  def test_remove_child
    o = Gloo::Core::Obj.new
    s = Gloo::Objs::String.new
    s.name = "str"
    o.add_child s
    assert_equal 1, o.child_count
    o.remove_child s
    assert_equal 0, o.child_count
  end

  def test_find_nonexistant_child
    o = Gloo::Core::Obj.new
    refute o.find_child( "xtr" )
    s = Gloo::Objs::String.new
    s.name = "str"
    o.add_child s
    assert_same s, o.find_child( "str" )
    refute o.find_child( "xtr" )
    refute o.find_child( "stri" )
    refute o.find_child( "st" )
  end
  
  def test_child_count
    o = Gloo::Core::Obj.new
    assert_equal 0, o.child_count
    o = Gloo::Objs::Container.new
    assert_equal 0, o.child_count
    s = Gloo::Objs::String.new
    s.name = "str"
    o.add_child s
    assert_equal 1, o.child_count
  end
  
  def test_type_display
    o = Gloo::Objs::Container.new
    assert_equal "container", o.type_display
    s = Gloo::Objs::String.new
    assert_equal "string", s.type_display
  end
  
  def test_value_display
    s = Gloo::Objs::String.new
    s.value = "test"
    assert_equal "test", s.value_display
  end
  
  def test_messages
    msgs = Gloo::Core::Obj.messages
    assert msgs
    assert msgs.include?( "unload" )
  end
  
  def test_can_receive_message
    o = Gloo::Core::Obj.new
    assert o.can_receive_message? "unload"
    refute o.can_receive_message? "xyz"
    refute o.can_receive_message? "123"
  end
  
  def test_sending_message
    o = @engine.factory.create "s", "string"
    refute o.send_message( "xyz" )
    refute o.send_message( "abc" )
    assert o.send_message( "unload" )
  end
  
  def test_dispatch
    o = @engine.factory.create "s", "string"
    refute o.dispatch "xyz"
    refute o.dispatch "abc"
    assert o.dispatch "unload"
  end
  
end
