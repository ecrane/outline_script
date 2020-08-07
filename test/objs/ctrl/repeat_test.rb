require 'test_helper'

class RepeatTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal 'repeat', Gloo::Objs::Repeat.typename
  end

  def test_the_short_typename
    assert_equal 'repeat', Gloo::Objs::Repeat.short_typename
  end

  def test_find_type
    assert @dic.find_obj( 'repeat' )
    assert @dic.find_obj( 'REPEAT' )
  end

  def test_messages
    msgs = Gloo::Objs::Repeat.messages
    assert msgs
    assert msgs.include?( 'run' )
    assert msgs.include?( 'unload' )
  end

  def test_adds_children_on_create
    o = Gloo::Objs::Repeat.new
    assert o.add_children_on_create?
  end

  def test_that_children_are_added_on_create
    i = @engine.parser.parse_immediate 'create r as repeat'
    i.run
    assert_equal 1, @engine.heap.root.child_count
    obj = @engine.heap.root.children.first
    assert obj
    assert_equal 'r', obj.name
    assert_equal 3, obj.child_count
    assert_equal 'times', obj.children.first.name
    assert_equal 'index', obj.children[ 1 ].name
    assert_equal 'do', obj.children.last.name
  end

  def test_help_text
    assert Gloo::Objs::Repeat.help.start_with? 'REPEAT OBJECT TYPE'
  end

end
