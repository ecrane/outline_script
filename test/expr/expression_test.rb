require "test_helper"

class ExpressionTest < Minitest::Test
  
  # def setup
  #   @engine = Gloo::App::Engine.new( [ "--quiet" ] )
  # end

  def test_expression_construction
    e = Gloo::Expr::Expression.new( nil )
    assert e
  end


end
