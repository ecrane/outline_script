require "test_helper"

class LoadTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ "--quiet" ] )
    @engine.start
  end
  
  def test_the_keyword
    assert_equal "load", Gloo::Verbs::Load.keyword
  end
  
  def test_the_keyword_shortcut
    assert_equal "<", Gloo::Verbs::Load.keyword_shortcut
  end


end
