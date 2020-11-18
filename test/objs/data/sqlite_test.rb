require 'test_helper'

class SqliteTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal 'sqlite', Gloo::Objs::Sqlite.typename
  end

  def test_the_short_typename
    assert_equal 'sqlite', Gloo::Objs::Sqlite.short_typename
  end

  def test_find_type
    assert @dic.find_obj( 'sqlite' )
    assert @dic.find_obj( 'SQLITE' )
    assert @dic.find_obj( 'Sqlite' )
  end

  def test_messages
    msgs = Gloo::Objs::Sqlite.messages
    assert msgs
    assert msgs.include?( 'verify' )
    assert msgs.include?( 'unload' )
  end

  def test_adds_children_on_create
    o = Gloo::Objs::Sqlite.new
    assert o.add_children_on_create?
  end

  def test_that_children_are_added_on_create
    i = @engine.parser.parse_immediate 'create o as sqlite'
    i.run
    assert_equal 1, @engine.heap.root.child_count
    obj = @engine.heap.root.children.first
    assert obj
    assert_equal 'o', obj.name
    assert_equal 1, obj.child_count
    assert_equal 'database', obj.children.first.name
  end

  def test_help_text
    assert @engine.help.topic? Gloo::Objs::Sqlite.typename
  end

end
