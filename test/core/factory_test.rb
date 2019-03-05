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

  def test_object_creation
    @engine.start
    o = @engine.factory.create
    refute o

    o = @engine.factory.create "s", "string"
    assert o
    assert_equal "s", o.name
  end

end
