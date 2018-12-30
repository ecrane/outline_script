require "test_helper"

class WordsTest < Minitest::Test
  
  def test_active_support
    o = OutlineScript::Utils::Words.pluralize( "Tomato" )
    assert_equal "Tomatoes", o
  end

end
