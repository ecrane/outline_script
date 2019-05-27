require "test_helper"

class FileLoaderTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ "--quiet" ] )
    @engine.start
  end

  def test_splitting_a_line
    fs = Gloo::Persist::FileLoader.new( "" )
    n, t, v = fs.split_line( "name type value\n" )
    assert_equal "name", n
    assert_equal "type", t
    assert_equal "value", v

    n, t, v = fs.split_line( "name [type] one two three\n" )
    assert_equal "name", n
    assert_equal "type", t
    assert_equal "one two three", v

    n, t, v = fs.split_line( "my_string [str] : xyz" )
    assert_equal "my_string", n
    assert_equal "str", t
    assert_equal "xyz", v
  end
  
  def test_tab_count
    fs = Gloo::Persist::FileLoader.new( "" )
    
    assert_equal 0, fs.tab_count( "one" )
    assert_equal 1, fs.tab_count( "\tone" )
    assert_equal 2, fs.tab_count( "\t\ttwo222" )
    assert_equal 3, fs.tab_count( "\t\t\tthree" )
    assert_equal 0, fs.tab_count( "  \t one" )
  end
  
  def test_loading_a_file
    assert_equal 0, @engine.heap.root.child_count
    o = @engine.persist_man.load "test"
    assert_equal 1, @engine.heap.root.child_count
    assert_equal "test", @engine.heap.root.children.first.name
  end

  def test_loading_a_file_that_doesnt_exist
    assert_equal 0, @engine.heap.root.child_count
    o = @engine.persist_man.load "xyz"
    assert_equal 0, @engine.heap.root.child_count
  end
  
  def test_skip_line
    o = Gloo::Persist::FileLoader.new( "" )
    assert o.skip_line? ""
    assert o.skip_line? "   "
    assert o.skip_line? "   \n"
    assert o.skip_line? "\t"
    assert o.skip_line? "# "
    assert o.skip_line? " # comment "
    assert o.skip_line? " \t # "
    
    refute o.skip_line? "go [can] :"
    refute o.skip_line? "s [string] : # "
  end

end
