require "test_helper"

class ShowTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
    @engine.start
  end

  def test_the_keyword
    assert_equal "show", OutlineScript::Verbs::Show.keyword
  end

  def test_showing_a_string_literal
    v = @engine.parser.parse_immediate 'show "me"'
    v.run
    assert_equal "me", @engine.heap.it.value
  end

end
