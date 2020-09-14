require 'test_helper'

class TellTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_the_keyword
    assert_equal 'tell', Gloo::Verbs::Tell.keyword
  end

  def test_the_keyword_shortcut
    assert_equal '->', Gloo::Verbs::Tell.keyword_shortcut
  end

  def test_sending_message_with_tell
    o = @engine.parser.parse_immediate 'create s as string'
    o.run
    assert_equal 1, @engine.heap.root.child_count
    o = @engine.parser.parse_immediate 'tell s to unload'
    o.run
    assert_equal 0, @engine.heap.root.child_count
  end

  def test_help_text
    assert @engine.help.topic? Gloo::Verbs::Tell.keyword
  end

end
