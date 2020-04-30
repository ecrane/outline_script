require 'test_helper'

class ObjFinderTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_by_name
    arr = Gloo::Core::ObjFinder.by_name "x"
    assert_equal [], arr

    i = @engine.parser.parse_immediate '` x'
    i.run
    arr = Gloo::Core::ObjFinder.by_name "x"
    assert_equal 1, arr.count
    assert_equal "x", arr.first.name

    i = @engine.parser.parse_immediate '` x.y'
    i.run
    arr = Gloo::Core::ObjFinder.by_name "y"
    assert_equal 1, arr.count
    assert_equal "y", arr.first.name
  end


end
