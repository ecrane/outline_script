require 'test_helper'

class PersistManTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_that_the_engine_has_persistence_manager
    assert @engine.persist_man
  end

  def test_construction
    o = Gloo::Persist::PersistMan.new
    assert o
    assert_equal 0, o.maps.count
  end

  def test_file_ext
    o = @engine.persist_man.file_ext
    assert_equal '.gloo', o
  end

  def test_full_path_names
    o = @engine.persist_man.get_full_path_names 'test'
    assert o
    assert_equal 1, o.count
    e = o.first
    assert e
    assert e.end_with? '/test.gloo'
    assert e.start_with? $settings.project_path
  end

  def test_load
    assert_equal 0, @engine.heap.root.child_count
    @engine.persist_man.load 'test'
    assert_equal 1, @engine.heap.root.child_count
    assert_equal 'test', @engine.heap.root.children.first.name
  end

end
