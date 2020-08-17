require 'test_helper'

class DispatchTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_message_dispatch
    s = Gloo::Objs::String.new
    s.value = 'abc'
    assert s
    assert_equal 'abc', s.value

    Gloo::Exec::Dispatch.message 'up', s
    assert_equal 'ABC', s.value
  end

  def test_action_dispatch
    s = Gloo::Objs::String.new
    s.value = 'abc'
    assert s
    assert_equal 'abc', s.value

    a = Gloo::Exec::Action.new 'up', s
    Gloo::Exec::Dispatch.action a
    assert_equal 'ABC', s.value
  end

end
