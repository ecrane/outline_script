require "test_helper"

class FactoryTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  end

  def test_factory_built_by_default
    assert @engine
    refute @engine.factory
    @engine.start
    assert @engine.factory
  end

end
