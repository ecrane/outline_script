require "test_helper"

class ShowTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  end

  def test_the_keyword
    assert_equal "show", OutlineScript::Verbs::Show.keyword
  end

  
end
