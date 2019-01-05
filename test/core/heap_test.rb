require "test_helper"

class HeapTest < Minitest::Test
  
  def test_heap_constrution
    OutlineScript::App::Engine.new( [ "--quiet" ] )
    o = OutlineScript::Core::Heap.new
    assert o
  end

  
end
