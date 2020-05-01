require 'test_helper'

class ScriptTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_running_a_script
    o = Gloo::Objs::Script.new
    o.set_value( 'show 2 + 3' )

    s = Gloo::Core::Script.new( o )
    assert s
    s.run
    assert_equal 5, @engine.heap.it.value
  end

end
