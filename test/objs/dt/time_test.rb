require 'test_helper'

class TimeTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal 'time', Gloo::Objs::Time.typename
  end

  def test_the_short_typename
    assert_equal 'time', Gloo::Objs::Time.short_typename
  end

  def test_find_type
    assert @dic.find_obj( 'Time' )
  end

  def test_messages
    msgs = Gloo::Objs::Time.messages
    assert msgs
    assert msgs.include?( 'now' )
  end

  def test_adds_children_on_create
    o = Gloo::Objs::Time.new
    refute o.add_children_on_create?
  end

  def test_now
    i = @engine.parser.parse_immediate 'create t as time'
    i.run
    t = @engine.heap.root.children.first
    assert t
    refute t.value

    i = @engine.parser.parse_immediate 'tell t to now'
    i.run
    refute_equal '', t.value
  end

  def test_help_text
    assert Gloo::Objs::Time.help.start_with? 'TIME OBJECT TYPE'
  end

end
