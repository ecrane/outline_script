require "test_helper"

class EngineTest < Minitest::Test
  
  def test_engine_constrution
    o = OutlineScript::Engine.new
    assert o
  end
  
end
