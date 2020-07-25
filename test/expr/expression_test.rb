require 'test_helper'

class ExpressionTest < Minitest::Test

  # def setup
  #   @engine = Gloo::App::Engine.new( [ '--quiet' ] )
  # end

  def test_expression_construction
    e = Gloo::Expr::Expression.new( nil )
    assert e
  end

  def test_tokenizing_decimals
    o = Gloo::Core::Tokens.new( '= 2.3 + 3.4' )
    assert o
    assert_equal 4, o.token_count

    e = Gloo::Expr::Expression.new( o.tokens )
    assert e

    e.identify_tokens
  end
end
