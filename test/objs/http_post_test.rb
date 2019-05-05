require "test_helper"

class HttpPostTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ "--quiet" ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal "http_post", Gloo::Objs::HttpPost.typename
  end

  def test_the_short_typename
    assert_equal "post", Gloo::Objs::HttpPost.short_typename
  end

  def test_find_type
    assert @dic.find_obj( "post" )
    assert @dic.find_obj( "POST" )
    assert @dic.find_obj( "http_post" )
  end

  def test_messages
    msgs = Gloo::Objs::HttpPost.messages
    assert msgs
    assert msgs.include?( "run" )
    assert msgs.include?( "unload" )
  end


end
