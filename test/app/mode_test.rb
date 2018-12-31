require "test_helper"

class ModeTest < Minitest::Test
    
  def test_mode
    mode = OutlineScript::App::Mode::EMBED
    assert mode
  end
  
end
