require 'test_helper'

class ExecuteTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_the_keyword
    assert_equal 'execute', Gloo::Verbs::Execute.keyword
  end

  def test_the_keyword_shortcut
    assert_equal 'exec', Gloo::Verbs::Execute.keyword_shortcut
  end

  def test_help_text
    assert @engine.help.topic? Gloo::Verbs::Execute.keyword
  end

  def test_without_expression
    @engine.parser.run 'execute'
    assert @engine.error?
    assert_equal Gloo::Verbs::Execute::MISSING_EXPR_ERR, @engine.heap.error.value
  end

end
