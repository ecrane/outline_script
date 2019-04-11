require "test_helper"

class IntegerTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal "integer", OutlineScript::Objs::Integer.typename
  end
  
  def test_the_short_typename
    assert_equal "int", OutlineScript::Objs::Integer.short_typename
  end

  def test_find_type
    assert @dic.find_obj( "integer" )
    assert @dic.find_obj( "INTEGER" )
    assert @dic.find_obj( "int" )
    assert @dic.find_obj( "INT" )
  end


  def test_setting_the_value
    o = OutlineScript::Objs::Integer.new
    o.set_value( 3 )
    assert_equal 3, o.value
    o.set_value( "177" )
    assert_equal 177, o.value
    o.set_value( " 1 " )
    assert_equal 1, o.value    
    o.set_value( -13 )
    assert_equal -13, o.value    
  end

end
