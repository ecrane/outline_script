require 'test_helper'

class HelpTest < Minitest::Test

  def test_the_application_help_text
    h = Gloo::App::Help.new
    t = h.get_topic_data 'application'
    assert t
    assert t.length > 100
  end

  def test_lazy_load_topic_index
    h = Gloo::App::Help.new
    refute h.topics

    h.lazy_load_index
    assert h.topics
    assert h.topics.count > 1
  end

  def test_if_has_topic
    h = Gloo::App::Help.new

    assert h.topic?( 'application' )
    assert h.topic?( 'help' )

    refute h.topic?( '3223ksjfaj23j' )
    refute h.topic?( 'xzy987' )
  end

end
