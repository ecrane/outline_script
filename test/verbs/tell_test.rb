require "test_helper"

class TellTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ "--quiet" ] )
    @engine.start
  end

  def test_the_keyword
    assert_equal "tell", Gloo::Verbs::Tell.keyword
  end

  def test_the_keyword_shortcut
    assert_equal "->", Gloo::Verbs::Tell.keyword_shortcut
  end


end
