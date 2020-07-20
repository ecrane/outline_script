require 'test_helper'

class TextTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal 'text', Gloo::Objs::Text.typename
  end

  def test_the_short_typename
    assert_equal 'txt', Gloo::Objs::Text.short_typename
  end

  def test_find_type
    assert @dic.find_obj( 'text' )
    assert @dic.find_obj( 'txt' )
  end

  def test_setting_the_value
    o = Gloo::Objs::Text.new
    o.set_value( "line one\nline two" )
    assert_equal "line one\nline two", o.value
  end

  def test_setting_the_line_count
    o = Gloo::Objs::Text.new
    o.set_value( "line one\nline two\nthree" )
    assert_equal 3, o.line_count
  end

  def test_messages
    msgs = Gloo::Objs::Text.messages
    assert msgs
    assert msgs.include?( 'edit' )
  end

  def test_help_text
    assert Gloo::Objs::Text.help.start_with? 'TEXT OBJECT TYPE'
  end

end
