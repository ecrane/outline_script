require "test_helper"

class VersionTest < Minitest::Test
  
  # def setup
  #   @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  # end

  def test_the_keyword
    assert_equal "version", OutlineScript::Verbs::Version.keyword
  end

  def test_the_keyword_shortcut
    assert_equal "v", OutlineScript::Verbs::Version.keyword_shortcut
  end

end
