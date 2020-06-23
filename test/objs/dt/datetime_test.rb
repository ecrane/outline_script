require 'test_helper'

class DatetimeTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal 'datetime', Gloo::Objs::Datetime.typename
  end

  def test_the_short_typename
    assert_equal 'dt', Gloo::Objs::Datetime.short_typename
  end

  def test_find_type
    assert @dic.find_obj( 'datetime' )
    assert @dic.find_obj( 'DT' )
  end

  def test_messages
    msgs = Gloo::Objs::Datetime.messages
    assert msgs
    assert msgs.include?( 'now' )
  end

  def test_adds_children_on_create
    o = Gloo::Objs::Datetime.new
    refute o.add_children_on_create?
  end

  def test_now
    i = @engine.parser.parse_immediate 'create dt as dt'
    i.run
    t = @engine.heap.root.children.first
    assert t
    refute t.value

    i = @engine.parser.parse_immediate 'tell dt to now'
    i.run
    refute_equal '', t.value
  end

  def test_help_text
    assert Gloo::Objs::Datetime.help.start_with? 'DATETIME OBJECT TYPE'
  end

end
