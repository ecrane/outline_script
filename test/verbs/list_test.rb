require 'test_helper'

class ListTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_the_keyword
    assert_equal 'list', Gloo::Verbs::List.keyword
  end

  def test_the_keyword_shortcut
    assert_equal '.', Gloo::Verbs::List.keyword_shortcut
  end

  def test_determine_target
    assert @engine.running
    i = @engine.parser.parse_immediate 'list'
    target = i.determine_target
    assert_same $engine.heap.context, target

    i = @engine.parser.parse_immediate 'list me'
    target = i.determine_target
    refute_same $engine.heap.context, target
    assert_equal 'me', target.to_s
  end

  def test_help_text
    assert @engine.help.topic? Gloo::Verbs::List.keyword
  end

end
