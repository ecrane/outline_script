require 'test_helper'

class JsonTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal 'json', Gloo::Objs::Json.typename
  end

  def test_the_short_typename
    assert_equal 'json', Gloo::Objs::Json.short_typename
  end

  def test_find_type
    assert @dic.find_obj( 'json' )
    assert @dic.find_obj( 'JSON' )
  end

  def test_setting_the_value
    o = Gloo::Objs::Json.new
    o.set_value( '{"title":"JSON data"}' )
    assert_equal '{"title":"JSON data"}', o.value
  end

  def test_help_text
    assert Gloo::Objs::Json.help.start_with? 'JSON OBJECT TYPE'
  end

end
