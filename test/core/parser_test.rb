require "test_helper"

class ParserTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
    @engine.start
  end

  def test_parser_constrution
    o = OutlineScript::Core::Parser.new
    assert o
  end

  def test_parse_immediate
    assert @engine.running
    i = @engine.parser.parse_immediate 'quit'
    assert i
  end

  def test_parse_immediate_no_verb
    assert @engine.running
    i = @engine.parser.parse_immediate 'xxxxxyyyyyzzzz'
    refute i
  end
  
end
