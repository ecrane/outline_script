require "test_helper"

class ArgsTest < Minitest::Test

  def test_default_mode
    o = OutlineScript::App::Engine.new
    assert o
    o.start
    assert_equal OutlineScript::App::Mode.default_mode, o.mode
  end
      
  def test_version_mode
    o = OutlineScript::App::Engine.new( [ "--version" ] )
    assert o
    o.start
    assert_equal OutlineScript::App::Mode::VERSION, o.mode
  end

  def test_help_mode
    o = OutlineScript::App::Engine.new( [ "--help" ] )
    assert o
    o.start
    assert_equal OutlineScript::App::Mode::HELP, o.mode
  end

  def test_cli_mode
    o = OutlineScript::App::Engine.new( [ "--cli" ] )
    assert o
    o.start
    assert_equal OutlineScript::App::Mode::CLI, o.mode
  end

  def test_embed_mode
    o = OutlineScript::App::Engine.new( [ "--embed" ] )
    assert o
    o.start
    assert_equal OutlineScript::App::Mode::EMBED, o.mode
  end

  def test_script_mode
    o = OutlineScript::App::Engine.new( [ "file1" ] )
    assert o
    o.start
    assert_equal OutlineScript::App::Mode::SCRIPT, o.mode
  end
  
end
