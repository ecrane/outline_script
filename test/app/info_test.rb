require "test_helper"

class InfoTest < Minitest::Test
  
  def test_version_number
    refute_nil Gloo::App::Info::VERSION
  end

  def test_app_name
    refute_nil Gloo::App::Info::APP_NAME
  end
  
  def test_the_display_name
    t = Gloo::App::Info.display_title
    assert t
    assert t.start_with? "Gloo"
    assert t.end_with? Gloo::App::Info::VERSION
  end
  
end
