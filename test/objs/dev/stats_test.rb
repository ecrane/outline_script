require 'test_helper'

class StatsTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal 'stats', Gloo::Objs::Stats.typename
  end

  def test_the_short_typename
    assert_equal 'stat', Gloo::Objs::Stats.short_typename
  end

  def test_find_type
    assert @dic.find_obj( 'stats' )
    assert @dic.find_obj( 'STAT' )
  end

  def test_messages
    msgs = Gloo::Objs::Stats.messages
    assert msgs
    assert msgs.include?( 'show_all' )
    assert msgs.include?( 'show_busy_folders' )
  end

  def test_adds_children_on_create
    o = Gloo::Objs::Stats.new
    assert o.add_children_on_create?
  end

  def test_that_children_are_added_on_create
    @engine.parser.run 'create s as stats'
    assert_equal 1, @engine.heap.root.child_count
    obj = @engine.heap.root.children.first
    assert obj
    assert_equal 's', obj.name
    assert_equal 2, obj.child_count
    assert_equal 'folder', obj.children.first.name
    assert_equal 'types', obj.children.last.name
  end

  def test_help_text
    assert @engine.help.topic? Gloo::Objs::Stats.typename
  end

end
