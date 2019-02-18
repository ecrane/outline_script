require "test_helper"

class CreateTest < Minitest::Test
  
  # def setup
  #   @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  # end

  def test_the_keyword
    assert_equal "create", OutlineScript::Verbs::Create.keyword
  end

  def test_the_keyword_shortcut
    assert_equal "`", OutlineScript::Verbs::Create.keyword_shortcut
  end

end
