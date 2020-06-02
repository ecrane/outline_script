require 'test_helper'

class FileHandleTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal 'file', Gloo::Objs::FileHandle.typename
  end

  def test_the_short_typename
    assert_equal 'dir', Gloo::Objs::FileHandle.short_typename
  end

  def test_find_type
    assert @dic.find_obj( 'file' )
    assert @dic.find_obj( 'FILE' )
    assert @dic.find_obj( 'dir' )
  end

  def test_messages
    msgs = Gloo::Objs::FileHandle.messages
    assert msgs
    assert msgs.include?( 'read' )
    assert msgs.include?( 'write' )
  end

  def test_adds_children_on_create
    o = Gloo::Objs::FileHandle.new
    refute o.add_children_on_create?
  end

  def test_help_text
    assert Gloo::Objs::FileHandle.help.start_with? 'FILE OBJECT TYPE'
  end

end
