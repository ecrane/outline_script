require "test_helper"

class EngineTest < Minitest::Test
  
  def test_engine_constrution
    o = Gloo::App::Engine.new
    assert o
    assert $engine
    assert_equal o, $engine
  end
  
  def test_that_we_can_start_the_engine
    o = Gloo::App::Engine.new( [ "--quiet" ] )
    assert o
    o.start
    assert_equal Gloo::App::Mode::EMBED, o.mode
  end

  def test_that_a_running_engine_has_a_mode
    o = Gloo::App::Engine.new( [ "--quiet" ] )
    assert o
    o.start
    assert o.mode
  end
  
  def test_that_the_engine_has_args
    o = Gloo::App::Engine.new
    assert o.args
  end

  def test_that_the_running_engine_has_a_parser
    o = Gloo::App::Engine.new( [ "--quiet" ] )
    o.start
    assert o.parser
  end

  def test_that_the_running_engine_has_an_object_heap
    o = Gloo::App::Engine.new( [ "--quiet" ] )
    o.start
    assert o.heap
  end

  def test_last_command_blank
    o = Gloo::App::Engine.new( [ "--quiet" ] )
    o.last_cmd = nil
    assert o.last_cmd_blank?
    o.last_cmd = ""
    assert o.last_cmd_blank?
    o.last_cmd = "  "
    assert o.last_cmd_blank?
    
    o.last_cmd = "quit"
    refute o.last_cmd_blank?    
  end
  
  def test_that_engine_has_event_manager
    o = Gloo::App::Engine.new( [ "--quiet" ] )
    o.start
    assert o.event_manager
  end
  
end
