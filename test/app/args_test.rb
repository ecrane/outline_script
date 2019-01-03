require "test_helper"

class ArgsTest < Minitest::Test

  def test_default_mode
    o = OutlineScript::App::Engine.new( [ "--quiet" ] )
    assert o
    o.start
    assert_equal OutlineScript::App::Mode.default_mode, o.mode
  end
      
  def test_version_mode
    o = OutlineScript::App::Engine.new( [ "--version", "--quiet" ] )
    assert o
    o.start
    assert_equal OutlineScript::App::Mode::VERSION, o.mode
  end
  
  def test_help_mode
    o = OutlineScript::App::Engine.new( [ "--help", "--quiet" ] )
    assert o
    o.start
    assert_equal OutlineScript::App::Mode::HELP, o.mode
  end
  
  def test_cli_mode
    o = OutlineScript::App::Engine.new( [ "--cli", "--quiet" ] )
    assert o
    o.start
    assert_equal OutlineScript::App::Mode::CLI, o.mode
  end
  
  def test_embed_mode
    o = OutlineScript::App::Engine.new( [ "--embed", "--quiet" ] )
    assert o
    o.start
    assert_equal OutlineScript::App::Mode::EMBED, o.mode
  end
  
  def test_script_mode
    o = OutlineScript::App::Engine.new( [ "file1", "--quiet" ] )
    assert o
    o.start
    assert_equal OutlineScript::App::Mode::SCRIPT, o.mode
  end

  def test_quiet
    o = OutlineScript::App::Engine.new( [ "--quiet" ] )
    assert o
    assert o.args.quiet?

    o = OutlineScript::App::Engine.new
    assert o
    refute o.args.quiet?
  end
  
end
