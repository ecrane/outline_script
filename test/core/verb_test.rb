require "test_helper"

class VerbTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  end

  def test_verb_creation
    o = OutlineScript::Core::Verb.new( nil )
    assert o
  end

  
end
