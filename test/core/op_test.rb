require "test_helper"

class OpTest < Minitest::Test
  
  # def setup
  #   @engine = Gloo::App::Engine.new( [ "--quiet" ] )
  #   @engine.start
  # end

  def test_is_op?
    assert Gloo::Core::Op.is_op?( " + " )
    assert Gloo::Core::Op.is_op?( "+" )
    assert Gloo::Core::Op.is_op?( "- " )
    assert Gloo::Core::Op.is_op?( " *" )
    assert Gloo::Core::Op.is_op?( "/" )
    refute Gloo::Core::Op.is_op?( "asdf" )
    refute Gloo::Core::Op.is_op?( "++++" )
    refute Gloo::Core::Op.is_op?( "23" )
  end
  
  def test_create_op_plus
    o = Gloo::Core::Op.create_op( "+" )
    assert o
    assert_same Gloo::Expr::OpPlus, o.class
  end

  def test_create_op_minus
    o = Gloo::Core::Op.create_op( "-" )
    assert o
    assert_same Gloo::Expr::OpMinus, o.class
  end

  def test_default_op
    o = Gloo::Core::Op.default_op
    assert o
    assert_same Gloo::Expr::OpPlus, o.class
  end
    
end
