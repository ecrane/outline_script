require 'test_helper'

class UntypedTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal "untyped", Gloo::Objs::Untyped.typename
  end

  def test_the_short_typename
    assert_equal "un", Gloo::Objs::Untyped.short_typename
  end

  def test_find_type
    assert @dic.find_obj( "untyped" )
    assert @dic.find_obj( "UNTYPED" )
    assert @dic.find_obj( "un" )
    assert @dic.find_obj( "UN" )
  end


end
