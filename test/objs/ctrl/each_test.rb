require 'test_helper'

class EachTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal 'each', Gloo::Objs::Each.typename
  end

  def test_the_short_typename
    assert_equal 'each', Gloo::Objs::Each.short_typename
  end

  def test_find_type
    assert @dic.find_obj( 'each' )
  end

  def test_messages
    msgs = Gloo::Objs::Each.messages
    assert msgs
    assert msgs.include?( 'run' )
    assert msgs.include?( 'unload' )
  end

  def test_adds_children_on_create
    o = Gloo::Objs::Each.new
    assert o.add_children_on_create?
  end

  def test_that_children_are_added_on_create
    i = @engine.parser.parse_immediate 'create for as each'
    i.run
    assert_equal 1, @engine.heap.root.child_count
    obj = @engine.heap.root.children.first
    assert obj
    assert_equal 'for', obj.name
    assert_equal 3, obj.child_count
    assert_equal 'word', obj.children.first.name
    assert_equal 'do', obj.children.last.name
  end

  def test_help_text
    assert @engine.help.topic? Gloo::Objs::Each.typename
  end

end
