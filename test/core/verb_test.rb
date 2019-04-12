require "test_helper"

class VerbTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ "--quiet" ] )
  end

  def test_verb_creation
    o = Gloo::Core::Verb.new( nil )
    assert o
  end

  
end
