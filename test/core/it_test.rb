require "test_helper"

class ItTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
    @engine.start
  end

  def test_it_constrution
    o = OutlineScript::Core::It.new
    assert o
    refute o.value
  end
  
  def test_setting_it
    o = OutlineScript::Core::It.new
    o.set_to "something"
    assert_equal "something", o.value
  end

  def test_to_s
    o = OutlineScript::Core::It.new
    o.set_to "other"
    assert_equal "other", "#{o}"
  end

  def test_setting_it_in_heap
    @engine.heap.it.set_to "boo"
    assert_equal "boo", @engine.heap.it.to_s
    assert_equal "boo", @engine.heap.it.value
  end
  
  def test_that_by_default_it_is_nil
    refute @engine.heap.it.value
  end
  
end
