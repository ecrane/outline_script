require "test_helper"

class ModeTest < Minitest::Test
    
  def test_mode
    mode = OutlineScript::App::Mode::EMBED
    assert mode
  end
  
  def test_default_mode
    default = OutlineScript::App::Mode.default_mode
    assert default
    assert_equal OutlineScript::App::Mode::EMBED, default
  end
  
end
