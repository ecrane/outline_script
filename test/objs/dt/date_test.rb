require 'test_helper'

class DateTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal 'date', Gloo::Objs::Date.typename
  end

  def test_the_short_typename
    assert_equal 'date', Gloo::Objs::Date.short_typename
  end

  def test_find_type
    assert @dic.find_obj( 'DAte' )
  end

  def test_messages
    msgs = Gloo::Objs::Date.messages
    assert msgs
    assert msgs.include?( 'now' )
  end

  def test_adds_children_on_create
    o = Gloo::Objs::Date.new
    refute o.add_children_on_create?
  end

  def test_now
    i = @engine.parser.parse_immediate 'create d as date'
    i.run
    t = @engine.heap.root.children.first
    assert t
    refute t.value

    i = @engine.parser.parse_immediate 'tell d to now'
    i.run
    refute_equal '', t.value
  end

  def test_help_text
    assert @engine.help.topic? Gloo::Objs::Date.typename
  end

end
