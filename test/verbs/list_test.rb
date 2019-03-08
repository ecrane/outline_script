require "test_helper"

class ListTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
    @engine.start
  end

  def test_the_keyword
    assert_equal "list", OutlineScript::Verbs::List.keyword
  end

  def test_determine_target
    assert @engine.running
    i = @engine.parser.parse_immediate 'list'
    target = i.determine_target
    assert_same $engine.heap.context, target
    
    i = @engine.parser.parse_immediate 'list me'
    target = i.determine_target
    refute_same $engine.heap.context, target
    assert_equal "me", target.to_s
  end

end
