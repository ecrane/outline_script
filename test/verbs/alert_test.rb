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
    @engine.parser.run 'alert "test passed"'
    assert_equal 'test passed', @engine.heap.it.value
  end

  def test_running_script
    @engine.parser.run 'create s as string : "boo"'
    @engine.parser.run 'alert s'
    assert_equal 'boo', @engine.heap.it.value
  end

  def test_help_text
    assert @engine.help.topic? Gloo::Verbs::Alert.keyword
  end

end
