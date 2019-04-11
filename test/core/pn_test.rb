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
  
  def test_construction
    o = OutlineScript::Core::Pn.new( nil )
    assert o
    refute o.src

    o = OutlineScript::Core::Pn.new( "" )
    assert o
    assert o.src
  end
  
  def test_setting_it
    o = OutlineScript::Core::Pn.root
    o.set_to "something.or.other"
    assert_equal "something.or.other", o.src
    assert_equal "something.or.other", "#{o}"
  end
  
  def test_resolve
    i = @engine.parser.parse_immediate '` one'
    i.run
    o = OutlineScript::Core::Pn.new( "one" ).resolve
    assert o
    assert_equal "one", o.name
  end

  def test_resolve_not_found
    o = OutlineScript::Core::Pn.new( "one" ).resolve
    refute o
  end

  def test_resolve_root
    o = OutlineScript::Core::Pn.root.resolve
    assert o
    assert_equal "root", o.name
  end
  
  def test_conversion_to_segments
    o = OutlineScript::Core::Pn.new( "a.b.c" )
    segments = o.segments
    assert_equal 3, segments.count
    assert_equal 'a', segments[0]
    assert_equal 'b', segments[1]
    assert_equal 'c', segments[2]
    
    o = OutlineScript::Core::Pn.new( "one" )
    segments = o.segments
    assert_equal 1, segments.count
    assert_equal 'one', segments[0]

    o = OutlineScript::Core::Pn.new( "" )
    assert_equal 0, o.segments.count

    o = OutlineScript::Core::Pn.new( nil )
    assert_equal 0, o.segments.count
  end
  
  def test_root_reference
    o = OutlineScript::Core::Pn.root
    assert o
    assert_equal "root", o.src
  end  
  
  def test_root_exists
    o = OutlineScript::Core::Pn.root
    assert o.exists?
  end
  
  def test_is_root
    o = OutlineScript::Core::Pn.root
    assert o.is_root?
    o.set_to "ROOT"
    assert o.is_root?
    o.set_to "rOOt"
    assert o.is_root?
    o.set_to "root "
    assert o.is_root?
    o.set_to "not_root"
    refute o.is_root?
    o.set_to "root!"
    refute o.is_root?
    o.set_to "something.else"
    refute o.is_root?
  end

  def test_to_s
    o = OutlineScript::Core::Pn.new( "other" )
    assert_equal "other", "#{o}"
  end

  
  def test_object_exists
    i = @engine.parser.parse_immediate '` can as container'
    i.run
    i = @engine.parser.parse_immediate '` can.x'
    i.run
    
    o = OutlineScript::Core::Pn.new "can"
    assert o.exists?
    o = OutlineScript::Core::Pn.new "can.x"
    assert o.exists?
  end
  
  def test_obj_does_not_exist
    o = OutlineScript::Core::Pn.new( "does.not.exist" )
    refute o.exists?
    o.set_to "root"
    assert o.exists?
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
  
  def test_find_child_missing_parent
    o = OutlineScript::Core::Pn.new "can.x"
    refute o.get_parent
    o = OutlineScript::Core::Pn.new "a.b.c"
    refute o.get_parent
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
