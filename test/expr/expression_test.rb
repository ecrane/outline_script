require "test_helper"

class ExpressionTest < Minitest::Test
  
  # def setup
  #   @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  # end

  def test_expression_construction
    e = OutlineScript::Expr::Expression.new( nil )
    assert e
  end


end
