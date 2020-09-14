require 'test_helper'

class SaveTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_the_keyword
    assert_equal 'save', Gloo::Verbs::Save.keyword
  end

  def test_the_keyword_shortcut
    assert_equal '>', Gloo::Verbs::Save.keyword_shortcut
  end

  def test_help_text
    assert @engine.help.topic? Gloo::Verbs::Save.keyword
  end

end
