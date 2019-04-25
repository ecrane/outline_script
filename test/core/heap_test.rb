require "test_helper"

class HeapTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ "--quiet" ] )
    @engine.start
  end

  def test_heap_constrution
    o = Gloo::Core::Heap.new
    assert o
    assert o.root
    assert 0, o.root.child_count
    
    assert o.context
    assert o.it
  end

  def test_unload_object
    o = @engine.factory.create "s", "string"
    assert_equal 1, @engine.heap.root.child_count
    @engine.heap.unload o
    assert_equal 0, @engine.heap.root.child_count    
  end

end
