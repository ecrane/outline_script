require 'test_helper'

class PutTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_the_keyword
    assert_equal 'put', Gloo::Verbs::Put.keyword
  end

  def test_the_keyword_shortcut
    assert_equal 'p', Gloo::Verbs::Put.keyword_shortcut
  end

  def test_put_into_str
    o = @engine.parser.parse_immediate 'create s as string'
    o.run
    assert_equal 1, @engine.heap.root.child_count
    s = @engine.heap.root.children.first
    assert_equal '', s.value

    o = @engine.parser.parse_immediate "put 'one' into s"
    o.run
    assert_equal 'one', s.value
  end

  def test_put_into_int
    o = @engine.parser.parse_immediate 'create i as int : 0'
    o.run
    assert_equal 1, @engine.heap.root.child_count
    i = @engine.heap.root.children.first
    assert_equal 0, i.value

    o = @engine.parser.parse_immediate 'put 147 into i'
    o.run
    assert_equal 147, i.value
  end

  def test_put_into_nonexistent_object
    o = @engine.parser.parse_immediate 'put 1 into x'
    o.run
    assert_equal 0, @engine.heap.root.child_count
  end

  def test_fetching_the_value_tokens
    o = @engine.parser.parse_immediate 'put x into y'
    value = o.fetch_value_tokens
    assert value
    assert 1, value.count

    o = @engine.parser.parse_immediate 'put x'
    value = o.fetch_value_tokens
    refute value
  end

  def test_putting_without_src
    o = @engine.parser.parse_immediate 'put into b'
    o.run
  end

  def test_putting_without_with
    o = @engine.parser.parse_immediate 'put a'
    o.run
  end

  def test_putting_without_dst
    o = @engine.parser.parse_immediate 'put a into'
    o.run
  end

end
