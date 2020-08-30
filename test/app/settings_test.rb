require 'test_helper'

class SettingsTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_creation
    s = Gloo::App::Settings.new 'TEST'
    assert s
    assert s.user_root
    assert s.log_path
    assert s.config_path
    assert s.project_path
  end

  def test_engine_settings
    assert $settings
    assert $settings.user_root
    assert $settings.log_path
    assert $settings.config_path
    assert $settings.project_path
  end

  def test_lines
    o = Gloo::App::Settings.lines
    assert o
    assert( o > 1 )
    assert( o < 99_999_999 )
  end

  def test_cols
    o = Gloo::App::Settings.cols
    assert o
    assert( o > 1 )
    assert( o < 99_999 )
  end

  def test_page_size
    o = Gloo::App::Settings.page_size
    assert o
    assert( o > 1 )
    assert( o < 999 )
  end

  def test_debug_not_on_for_test
    refute $settings.debug
  end

  def test_in_test_mode
    assert $settings.in_test_mode?
  end

end
