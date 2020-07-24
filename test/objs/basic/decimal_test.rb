require 'test_helper'

class DecimalTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal 'decimal', Gloo::Objs::Decimal.typename
  end

  def test_the_short_typename
    assert_equal 'num', Gloo::Objs::Decimal.short_typename
  end

  def test_find_type
    assert @dic.find_obj( 'Decimal' )
    assert @dic.find_obj( 'DEciMAl' )
    assert @dic.find_obj( 'NUM' )
    assert @dic.find_obj( 'num' )
  end

  def test_setting_the_value
    o = Gloo::Objs::Decimal.new
    o.set_value( 3 )
    assert_equal 3.0, o.value
    # o.set_value( '177' )
    # assert_equal 177.0, o.value
    # o.set_value( ' 1.3 ' )
    # assert_equal 1.3, o.value
    o.set_value( -13.987 )
    assert_equal( -13.987, o.value )
  end

  def test_messages
    msgs = Gloo::Objs::Decimal.messages
    assert msgs
    assert msgs.include?( 'round' )
    assert msgs.include?( 'unload' )
  end

  # def test_inc_msg
  #   o = Gloo::Objs::Decimal.new
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
  #   assert_equal( -1, o.msg_dec )
  #   assert_equal( -1, o.value )
  #   assert_equal( -1, $engine.heap.it.value )
  # end

  def test_help_text
    assert Gloo::Objs::Decimal.help.start_with? 'DECIMAL OBJECT TYPE'
  end

end
