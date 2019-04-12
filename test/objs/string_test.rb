require "test_helper"

class StringTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ "--quiet" ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal "string", Gloo::Objs::String.typename
  end
  
  def test_the_short_typename
    assert_equal "str", Gloo::Objs::String.short_typename
  end

  def test_find_type
    assert @dic.find_obj( "string" )
    assert @dic.find_obj( "STRING" )
    assert @dic.find_obj( "str" )
    assert @dic.find_obj( "STR" )
  end

  def test_setting_the_value
    o = Gloo::Objs::String.new
    o.set_value( "a string" )
    assert_equal "a string", o.value
    o.set_value( 3 )
    assert_equal "3", o.value
    o.set_value( "177" )
    assert_equal "177", o.value
    o.set_value( " 1 " )
    assert_equal " 1 ", o.value    
    o.set_value( -13 )
    assert_equal "-13", o.value    
  end


end
