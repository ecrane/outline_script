require 'test_helper'

class EventManagerTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_on_load
    cmd = '` on_load as script : "show 2 + 2"'
    i = @engine.parser.parse_immediate cmd
    i.run
    
    refute_equal 4, @engine.heap.it.value
    @engine.event_manager.on_load nil, true
    assert_equal 4, @engine.heap.it.value
  end


end
