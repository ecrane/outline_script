require 'test_helper'

class QuitTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
  end

  def test_quit_verb
    @engine.start
    assert @engine.running
    q = Gloo::Verbs::Quit.new( nil )
    q.run
    refute @engine.running
  end

  def test_the_keyword
    o = Gloo::Verbs::Quit.keyword
    assert_equal 'quit', o
  end

  def test_the_keyword_shortcut
    assert_equal 'q', Gloo::Verbs::Quit.keyword_shortcut
  end

end
