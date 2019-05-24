require "test_helper"

class GlooSystemTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ "--quiet" ] )
    @engine.start
  end
  
  def test_the_typename
    assert_equal "gloo", Gloo::Core::GlooSystem.typename
  end

  def test_the_short_typename
    assert_equal "$", Gloo::Core::GlooSystem.short_typename
  end

  def test_marked_as_cannot_be_created
    refute Gloo::Core::GlooSystem.can_create?
    assert Gloo::Objs::Script.can_create?
    assert Gloo::Objs::String.can_create?
  end

  def test_cannot_be_created
    assert_equal 0, @engine.heap.root.child_count
    i = @engine.parser.parse_immediate 'create s as gloo :'
    i.run
    assert_equal 0, @engine.heap.root.child_count
    i = @engine.parser.parse_immediate 'create s as $ :'
    i.run
    assert_equal 0, @engine.heap.root.child_count
  end
  
  def test_param
    pn = Gloo::Core::Pn.new "$.hostname"
    o = Gloo::Core::GlooSystem.new( pn )
    assert o
    assert o.pn
    assert_equal "hostname", o.param

    pn = Gloo::Core::Pn.new "$.user.home"
    o = Gloo::Core::GlooSystem.new( pn )
    assert o
    assert o.pn
    assert_equal "user_home", o.param
  end
  
  def test_no_value
    i = @engine.parser.parse_immediate 'show $.asdfjasdfj'
    i.run
    assert_equal false, @engine.heap.it.value
  end

  def test_hostname
    i = @engine.parser.parse_immediate 'show $.hostname'
    i.run
    assert_equal Socket.gethostname, @engine.heap.it.value
  end
  
  
end
