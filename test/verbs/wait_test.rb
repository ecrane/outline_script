require 'test_helper'

class WaitTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_the_keyword
    assert_equal 'wait', Gloo::Verbs::Wait.keyword
  end

  def test_the_keyword_shortcut
    assert_equal 'w', Gloo::Verbs::Wait.keyword_shortcut
  end

  def test_help_text
    assert @engine.help.topic? Gloo::Verbs::Wait.keyword
  end

end
