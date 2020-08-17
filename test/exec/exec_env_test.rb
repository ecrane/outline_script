require 'test_helper'

class ExecEnvTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_getting_engines_exec_env
    o = $engine.exec_env
    assert o
  end

  def test_verbs_stack
    o = $engine.exec_env.verbs
    assert o
    assert_equal 0, o.size
  end

  def test_actions_stack
    o = $engine.exec_env.actions
    assert o
    assert_equal 0, o.size
  end

  def test_scripts_stack
    o = $engine.exec_env.scripts
    assert o
    assert_equal 0, o.size
  end

end
