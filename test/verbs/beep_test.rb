require 'test_helper'

class BeepTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_beep_verb
    @engine.start
    assert @engine.running
    q = Gloo::Verbs::Beep.new( nil )
    q.run
  end

  def test_the_keyword
    o = Gloo::Verbs::Beep.keyword
    assert_equal 'beep', o
  end

  def test_the_keyword_shortcut
    assert_equal 'b', Gloo::Verbs::Beep.keyword_shortcut
  end

  def test_help_text
    assert @engine.help.topic? Gloo::Verbs::Beep.keyword
  end

end
