require "test_helper"

class SaveTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ "--quiet" ] )
    @engine.start
  end
  
  def test_the_keyword
    assert_equal "save", Gloo::Verbs::Save.keyword
  end
  
  def test_the_keyword_shortcut
    assert_equal "s", Gloo::Verbs::Save.keyword_shortcut
  end


end
