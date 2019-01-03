require "test_helper"

class EngineTest < Minitest::Test
  
  def test_engine_constrution
    o = OutlineScript::App::Engine.new
    assert o
    assert $engine
    assert_equal o, $engine
  end
  
  def test_that_we_can_start_the_engine
    o = OutlineScript::App::Engine.new( [ "--quiet" ] )
    assert o
    o.start
    assert_equal OutlineScript::App::Mode::EMBED, o.mode
  end

  def test_that_a_running_engine_has_a_mode
    o = OutlineScript::App::Engine.new( [ "--quiet" ] )
    assert o
    o.start
    assert o.mode
  end
  
  def test_that_the_engine_has_args
    o = OutlineScript::App::Engine.new
    assert o.args
  end
  
end
