require "test_helper"

class OutlineScriptTest < Minitest::Test
  
  def test_that_it_has_a_version_number
    refute_nil ::OutlineScript::App::Info::VERSION
  end
    
end
