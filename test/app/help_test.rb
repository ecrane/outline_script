require "test_helper"

class HelpTest < Minitest::Test
  
  def test_the_display_name
    t = OutlineScript::App::Help.get_help_text
    assert t
    assert t.length > 100
  end
  
end
