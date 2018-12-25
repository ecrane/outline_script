require "test_helper"

class OutlineScriptTest < Minitest::Test
  
  def test_that_it_has_a_version_number
    refute_nil ::OutlineScript::VERSION
  end

  def test_active_support
    o = OutlineScript.pluralize( "Tomato" )
    assert_equal "Tomatoes", o
  end
  
end
