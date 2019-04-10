require "test_helper"

class PnTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
    @engine.start
  end

  def test_path_name_construction
    o = OutlineScript::Core::Pn.new "x"
    assert o
    assert_equal "x", o.src
    assert_equal 1, o.elements.count
  end
  
  def test_getting_parent_for_child
    i = @engine.parser.parse_immediate '` can as container'
    i.run
    can = @engine.heap.root.find_child 'can'
    assert can
    assert_equal "can", can.name
    
    o = OutlineScript::Core::Pn.new "can.x"
    parent = o.get_parent
    assert parent
    assert_same can, parent
  end
  
  
  def test_getting_parent_for_root
    o = OutlineScript::Core::Pn.new "a"
    assert_same @engine.heap.root, o.get_parent
  end
  
  def test_getting_name
    o = OutlineScript::Core::Pn.new ""
    assert_equal "", o.name

    o = OutlineScript::Core::Pn.new "a"
    assert_equal "a", o.name

    o = OutlineScript::Core::Pn.new "a.b.c"
    assert_equal "c", o.name
  end
  
  def test_has_name
    o = OutlineScript::Core::Pn.new ""
    refute o.has_name?
    
    o = OutlineScript::Core::Pn.new "x"
    assert o.has_name?

    o = OutlineScript::Core::Pn.new "x.y"
    assert o.has_name?
  end
  
  def test_has_path
    o = OutlineScript::Core::Pn.new ""
    refute o.has_path?
    
    o = OutlineScript::Core::Pn.new "x"
    refute o.has_path?

    o = OutlineScript::Core::Pn.new "x.y"
    assert o.has_path?

    o = OutlineScript::Core::Pn.new "x.y.z"
    assert o.has_path?
  end

end
