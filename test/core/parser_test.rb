require "test_helper"

class ParserTest < Minitest::Test
  
  def test_parser_constrution
    OutlineScript::App::Engine.new( [ "--quiet" ] )
    o = OutlineScript::Core::Parser.new
    assert o
  end

  
end
