require "test_helper"

class ParserTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  end

  def test_parser_constrution
    o = OutlineScript::Core::Parser.new
    assert o
  end

  
end
