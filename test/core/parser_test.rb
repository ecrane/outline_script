require "test_helper"

class ParserTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ "--quiet" ] )
    @engine.start
  end

  def test_parser_constrution
    o = Gloo::Core::Parser.new
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
  
  def test_parser_run
    @engine.parser.run '= 10 + 3 - 0'
    assert_equal 13, @engine.heap.it.value
  end

end
