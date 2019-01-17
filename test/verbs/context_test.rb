require "test_helper"

class ContextTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  end

  def test_the_keyword
    assert_equal "context", OutlineScript::Verbs::Context.keyword
  end

  
end
