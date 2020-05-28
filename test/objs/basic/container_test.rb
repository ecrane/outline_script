require 'test_helper'

class ContainerTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal 'container', Gloo::Objs::Container.typename
  end

  def test_the_short_typename
    assert_equal 'can', Gloo::Objs::Container.short_typename
  end

  def test_find_type
    assert @dic.find_obj( 'container' )
    assert @dic.find_obj( 'CONTAINER' )
    assert @dic.find_obj( 'can' )
    assert @dic.find_obj( 'CAN' )
  end

  def test_messages
    msgs = Gloo::Objs::Container.messages
    assert msgs
    assert msgs.include?( 'count' )
    assert msgs.include?( 'unload' )
  end

  def test_count_msg
    o = Gloo::Objs::Container.new
    assert_equal 0, o.msg_count
    o.add_child o
    assert_equal 1, o.msg_count
  end

  def test_doesnt_add_children_on_create
    o = Gloo::Objs::Container.new
    refute o.add_children_on_create?
  end

  def test_help_text
    assert Gloo::Objs::Container.help.start_with? 'CONTAINER OBJECT TYPE'
  end

end
