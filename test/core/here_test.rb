require 'test_helper'

class HereTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_includes_here_ref
    o = Gloo::Core::Pn.new 'abc'
    refute Gloo::Core::Here.includes_here_ref?( o.elements )

    o = Gloo::Core::Pn.new 'z.y.x'
    refute Gloo::Core::Here.includes_here_ref?( o.elements )

    o = Gloo::Core::Pn.new '^^.zyx'
    assert Gloo::Core::Here.includes_here_ref?( o.elements )

    o = Gloo::Core::Pn.new '^.one.two'
    assert Gloo::Core::Here.includes_here_ref?( o.elements )
  end

end
