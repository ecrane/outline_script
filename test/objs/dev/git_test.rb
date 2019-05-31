require "test_helper"

class GitTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ "--quiet" ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal "git_repo", Gloo::Objs::Git.typename
  end

  def test_the_short_typename
    assert_equal "git", Gloo::Objs::Git.short_typename
  end

  def test_find_type
    assert @dic.find_obj( "git_repo" )
    assert @dic.find_obj( "git" )
  end

  def test_messages
    msgs = Gloo::Objs::Git.messages
    assert msgs
    assert msgs.include?( "validate" )
    assert msgs.include?( "check_changes" )
  end

  def test_adds_children_on_create
    o = Gloo::Objs::Git.new
    assert o.add_children_on_create?
  end

  def test_that_children_are_added_on_create
    i = @engine.parser.parse_immediate 'create o as git'
    i.run
    assert_equal 1, @engine.heap.root.child_count
    obj = @engine.heap.root.children.first
    assert obj
    assert_equal "o", obj.name
    assert_equal 1, obj.child_count
    assert_equal "path", obj.children.first.name
  end

end
