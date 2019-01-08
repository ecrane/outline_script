require "test_helper"

class DictionaryTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  end

  def test_dictionary_constrution
    o = OutlineScript::Core::Dictionary.instance
    assert o
  end

  
end
