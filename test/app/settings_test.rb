require "test_helper"

class SettingsTest < Minitest::Test
  
  def test_creation
    Gloo::App::Engine.new( [ "--quiet" ] )
    assert $settings
    assert $settings.user_root
    assert $settings.log_path    
    assert $settings.config_path
    assert $settings.project_path
  end
  
  def test_lines
    o = Gloo::App::Settings.lines
    assert o
    assert o > 1
    assert o < 99999999
  end

  def test_cols
    o = Gloo::App::Settings.cols
    assert o
    assert o > 1
    assert o < 99999
  end

  def test_page_size
    o = Gloo::App::Settings.page_size
    assert o
    assert o > 1
    assert o < 999
  end

  def test_cols
    o = Gloo::App::Settings.preview_lines
    assert o
    assert o > 1
    assert o < 99
  end

  
end
