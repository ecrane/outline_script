require "test_helper"

class DictionaryTest < Minitest::Test
  
  def test_dictionary_constrution
    OutlineScript::App::Engine.new( [ "--quiet" ] )
    o = OutlineScript::Core::Dictionary.instance
    assert o
  end

  
end
