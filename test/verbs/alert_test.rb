require 'test_helper'

class AlertTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_the_keyword
    assert_equal 'alert', Gloo::Verbs::Alert.keyword
  end

  def test_the_keyword_shortcut
    assert_equal '!', Gloo::Verbs::Alert.keyword_shortcut
  end

  def test_running_script
    i = @engine.parser.parse_immediate 'alert "test passed"'
    i.run
    assert_equal 'test passed', @engine.heap.it.value
  end

  def test_help_text
    assert Gloo::Verbs::Alert.help.start_with? 'ALERT VERB'
  end

end
