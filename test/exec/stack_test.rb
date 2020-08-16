require 'test_helper'

class StackTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_getting_engine_stack
    o = $engine.stack
    assert o
  end

  def test_verb_debug_file
    o = $engine.stack.verb_debug_file
    assert o
    assert o.end_with? Gloo::Exec::Stack::VERB_DEBUG
  end

end
