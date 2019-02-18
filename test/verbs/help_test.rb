require "test_helper"

class HelpTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  end

  def test_help_verb
    @engine.start
    assert @engine.running
    v = OutlineScript::Verbs::Help.new( nil )
    v.run
    assert @engine.running
  end

  def test_the_keyword
    assert_equal "help", OutlineScript::Verbs::Help.keyword
  end

  def test_the_keyword_shortcut
    assert_equal "?", OutlineScript::Verbs::Help.keyword_shortcut
  end

  
end
