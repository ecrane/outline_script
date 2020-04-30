require 'test_helper'

class BooleanTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal "boolean", Gloo::Objs::Boolean.typename
  end
  
  def test_the_short_typename
    assert_equal "bool", Gloo::Objs::Boolean.short_typename
  end

  def test_is_boolean
    assert Gloo::Expr::LBoolean.is_boolean?( true )
    assert Gloo::Expr::LBoolean.is_boolean?( false )
    assert Gloo::Expr::LBoolean.is_boolean?( "true" )
    assert Gloo::Expr::LBoolean.is_boolean?( "false" )
    assert Gloo::Expr::LBoolean.is_boolean?( "TRUE" )
    assert Gloo::Expr::LBoolean.is_boolean?( "False" )
    refute Gloo::Expr::LBoolean.is_boolean?( "a" )
    refute Gloo::Expr::LBoolean.is_boolean?( 1 )
  end

  def test_find_type
    assert @dic.find_obj( "boolean" )
    assert @dic.find_obj( "BOOLEAN" )
    assert @dic.find_obj( "bool" )
    assert @dic.find_obj( "BOOL" )
  end

  def test_setting_the_value_to_true
    o = Gloo::Objs::Boolean.new
    o.set_value( 3 )
    assert_equal true, o.value
    o.set_value( -1 )
    assert_equal true, o.value
    o.set_value( 1 )
    assert_equal true, o.value
    o.set_value( "tRUe" )
    assert_equal true, o.value
    o.set_value( "TRUE" )
    assert_equal true, o.value    
    o.set_value( "t" )
    assert_equal true, o.value    
  end

  def test_setting_the_value_to_false
    o = Gloo::Objs::Boolean.new
    o.set_value( 0 )
    assert_equal false, o.value
    o.set_value( "false" )
    assert_equal false, o.value
    o.set_value( "FALSE" )
    assert_equal false, o.value    
    o.set_value( "f" )
    assert_equal false, o.value    
  end
  
  def test_messages
    msgs = Gloo::Objs::Boolean.messages
    assert msgs
    assert msgs.include?( "not" )
    assert msgs.include?( "true" )
    assert msgs.include?( "false" )
  end

  # def test_inc_msg
  #   o = Gloo::Objs::Integer.new
  #   o.set_value 0
  #   assert_equal 0, o.value
  #   assert_equal 1, o.msg_inc    
  #   assert_equal 1, o.value
  #   assert_equal 1, $engine.heap.it.value
  # end
  # 
  # def test_dec_msg
  #   o = Gloo::Objs::Integer.new
  #   o.set_value 0
  #   assert_equal 0, o.value
  #   assert_equal -1, o.msg_dec    
  #   assert_equal -1, o.value
  #   assert_equal -1, $engine.heap.it.value
  # end

end
