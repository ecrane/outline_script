require "test_helper"

class PutTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ "--quiet" ] )
    @engine.start
  end

  def test_the_keyword
    assert_equal "put", Gloo::Verbs::Put.keyword
  end

  def test_the_keyword_shortcut
    assert_equal "p", Gloo::Verbs::Put.keyword_shortcut
  end

  def test_put_into_str
    o = @engine.parser.parse_immediate "create s as string"
    o.run
    assert_equal 1, @engine.heap.root.child_count
    s = @engine.heap.root.children.first
    assert_equal "", s.value
    
    o = @engine.parser.parse_immediate "put 'one' into s"
    o.run
    assert_equal "one", s.value
  end

  def test_put_into_int
    o = @engine.parser.parse_immediate "create i as int : 0"
    o.run
    assert_equal 1, @engine.heap.root.child_count
    i = @engine.heap.root.children.first
    assert_equal 0, i.value
    
    o = @engine.parser.parse_immediate "put 147 into i"
    o.run
    assert_equal 147, i.value
  end


end
