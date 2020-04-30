require 'test_helper'

class ArgsTest < Minitest::Test

  def test_default_mode
    o = Gloo::App::Engine.new( [ '--quiet' ] )
    assert o
    o.start
    assert_equal Gloo::App::Mode.default_mode, o.mode
  end
      
  def test_version_mode
    o = Gloo::App::Engine.new( [ "--version", '--quiet' ] )
    assert o
    o.start
    assert_equal Gloo::App::Mode::VERSION, o.mode
  end
  
  def test_help_mode
    o = Gloo::App::Engine.new( [ "--help", '--quiet' ] )
    assert o
    o.start
    assert_equal Gloo::App::Mode::HELP, o.mode
  end
  
  def test_cli_mode
    o = Gloo::App::Engine.new( [ "--cli", '--quiet' ] )
    assert o
    o.start
    assert_equal Gloo::App::Mode::CLI, o.mode
  end
  
  def test_embed_mode
    o = Gloo::App::Engine.new( [ "--embed", '--quiet' ] )
    assert o
    o.start
    assert_equal Gloo::App::Mode::EMBED, o.mode
  end
  
  def test_script_mode
    o = Gloo::App::Engine.new( [ "test", '--quiet' ] )
    assert o
    o.start
    assert_equal Gloo::App::Mode::SCRIPT, o.mode
  end

  def test_quiet
    o = Gloo::App::Engine.new( [ '--quiet' ] )
    assert o
    assert o.args.quiet?

    o = Gloo::App::Engine.new
    assert o
    refute o.args.quiet?
  end
  
end
