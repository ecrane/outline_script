require "test_helper"

class InfoTest < Minitest::Test
  
  def test_version_number
    refute_nil OutlineScript::Info::VERSION
  end

  def test_app_name
    refute_nil OutlineScript::Info::APP_NAME
  end
  
  def test_the_display_name
    t = OutlineScript::Info.display_title
    assert t
    assert t.start_with? "Outline"
    assert t.end_with? OutlineScript::Info::VERSION
  end
  
end
