require "test_helper"

class ScriptTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ "--quiet" ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal "script", Gloo::Objs::Script.typename
  end
  
  def test_the_short_typename
    assert_equal "cmd", Gloo::Objs::Script.short_typename
  end

  def test_find_type
    assert @dic.find_obj( "script" )
    assert @dic.find_obj( "SCRIPT" )
    assert @dic.find_obj( "cmd" )
    assert @dic.find_obj( "CMD" )
  end

  def test_setting_the_value
    o = Gloo::Objs::Script.new
    o.set_value( "show 2 + 3" )
    assert_equal "show 2 + 3", o.value
  end
  
  def test_messages
    msgs = Gloo::Objs::Script.messages
    assert msgs
    assert msgs.include?( "run" )
    assert msgs.include?( "unload" )
  end



end
