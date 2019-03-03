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
  
  def test_setting_it
    o = OutlineScript::Core::ObjRef.root
    o.set_to "something.or.other"
    assert_equal "something.or.other", o.raw
    assert_equal "something.or.other", "#{o}"
  end
  
  def test_root_exists
    o = OutlineScript::Core::ObjRef.root
    assert o.obj_exists?
  end

  def test_obj_exists
    o = OutlineScript::Core::ObjRef.new( "does.not.exist" )
    refute o.obj_exists?
    o.set_to "root"
    assert o.obj_exists?
  end
  
  def test_is_root
    o = OutlineScript::Core::ObjRef.root
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
    o = OutlineScript::Core::ObjRef.new( "other" )
    assert_equal "other", "#{o}"
  end

end
