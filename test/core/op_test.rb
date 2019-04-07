require "test_helper"

class OpTest < Minitest::Test
  
  # def setup
  #   @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  #   @engine.start
  # end

  def test_is_op?
    assert OutlineScript::Core::Op.is_op?( " + " )
    assert OutlineScript::Core::Op.is_op?( "+" )
    assert OutlineScript::Core::Op.is_op?( "- " )
    assert OutlineScript::Core::Op.is_op?( " *" )
    assert OutlineScript::Core::Op.is_op?( "/" )
    refute OutlineScript::Core::Op.is_op?( "asdf" )
    refute OutlineScript::Core::Op.is_op?( "++++" )
    refute OutlineScript::Core::Op.is_op?( "23" )
  end
  
  def test_create_op_plus
    o = OutlineScript::Core::Op.create_op( "+" )
    assert o
    assert_same OutlineScript::Expr::OpPlus, o.class
  end

  def test_create_op_minus
    o = OutlineScript::Core::Op.create_op( "-" )
    assert o
    assert_same OutlineScript::Expr::OpMinus, o.class
  end

  def test_default_op
    o = OutlineScript::Core::Op.default_op
    assert o
    assert_same OutlineScript::Expr::OpPlus, o.class
  end
    
end
