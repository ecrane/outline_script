require "test_helper"

class HeapTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  end

  def test_heap_constrution
    o = OutlineScript::Core::Heap.new
    assert o
  end

  
end