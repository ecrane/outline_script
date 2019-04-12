require "test_helper"

class FactoryTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ "--quiet" ] )
  end

  def test_factory_built_by_default
    assert @engine
    refute @engine.factory
    @engine.start
    assert @engine.factory
  end

  def test_unknown_object_creation
    @engine.start
    o = @engine.factory.create "s", "string"
    assert o
    assert_equal "s", o.name
    assert_equal "string", o.type_display
  end

  def test_unknown_object_creation
    @engine.start
    o = @engine.factory.create "x", "notatype"
    refute o
  end

  def test_untyped_object_creation
    @engine.start
    o = @engine.factory.create "u"
    assert o
    assert_equal "u", o.name
    assert_equal "untyped", o.type_display
  end

end
