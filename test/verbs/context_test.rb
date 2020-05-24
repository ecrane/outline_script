require 'test_helper'

class ContextTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_showing_the_context
    assert @engine.running
    assert_equal 'root', @engine.heap.context.to_s

    i = @engine.parser.parse_immediate '@'
    i&.run
    assert_equal 'root', @engine.heap.context.to_s
  end

  def test_setting_the_context
    assert @engine.running
    assert_equal 'root', @engine.heap.context.to_s

    i = @engine.parser.parse_immediate '@ bob'
    i&.run
    assert_equal 'bob', @engine.heap.it.to_s
  end

  def test_the_keyword
    assert_equal 'context', Gloo::Verbs::Context.keyword
  end

  def test_the_keyword_shortcut
    assert_equal '@', Gloo::Verbs::Context.keyword_shortcut
  end

  def test_help_text
    assert Gloo::Verbs::Context.help.start_with? 'CONTEXT VERB'
  end

end
