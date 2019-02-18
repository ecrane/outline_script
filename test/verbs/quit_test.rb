require "test_helper"

class QuitTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  end

  def test_quit_verb
    @engine.start
    assert @engine.running
    q = OutlineScript::Verbs::Quit.new( nil )
    q.run
    refute @engine.running
  end

  def test_the_keyword
    o = OutlineScript::Verbs::Quit.keyword
    assert_equal "quit", o
  end

  def test_the_keyword_shortcut
    assert_equal "q", OutlineScript::Verbs::Quit.keyword_shortcut
  end

  
end
