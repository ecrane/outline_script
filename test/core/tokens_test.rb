require "test_helper"

class TokensTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  end

  def test_creation_of_token_list
    o = OutlineScript::Core::Tokens.new( "quit" )
    assert o
  end

  def test_that_list_contains_item
    o = OutlineScript::Core::Tokens.new( "quit" )
    assert o.tokens
    assert_equal 1, o.tokens.count
  end

  def test_the_verb
    o = OutlineScript::Core::Tokens.new( "quit" )
    assert o.verb
    assert_equal "quit", o.verb
  end

  
end
