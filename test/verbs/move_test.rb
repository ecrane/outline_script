require 'test_helper'

class MoveTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_the_keyword
    assert_equal 'move', Gloo::Verbs::Move.keyword
  end

  def test_the_keyword_shortcut
    assert_equal 'mv', Gloo::Verbs::Move.keyword_shortcut
  end

  def test_moving_an_object
    o = @engine.parser.parse_immediate 'create s as string'
    o.run
    assert_equal 1, @engine.heap.root.child_count

    s = @engine.heap.root.children.first
    assert_equal 'root', s.parent.name

    can = @engine.parser.parse_immediate 'create can as container'
    can.run
    assert_equal 2, @engine.heap.root.child_count

    o = @engine.parser.parse_immediate 'move s to can'
    o.run
    assert_equal 'can', s.parent.name
    assert_equal 1, @engine.heap.root.child_count
  end

  def test_moving_without_object_to_move
    o = @engine.parser.parse_immediate 'move to b'
    o.run
    assert $engine.error?
  end

  def test_moving_without_to
    o = @engine.parser.parse_immediate 'move a'
    o.run
    assert $engine.error?
  end

  def test_moving_without_dst
    o = @engine.parser.parse_immediate 'move a to'
    o.run
    assert $engine.error?
  end

  def test_help_text
    assert @engine.help.topic? Gloo::Verbs::Move.keyword
  end

end
