require "test_helper"

class DictionaryTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
    @engine.start
    @dic = OutlineScript::Core::Dictionary.instance
  end

  def test_dictionary_constrution
    assert @dic
  end

  def test_verb_list
    assert @dic.verbs
    assert ( @dic.verbs.count > 0 )
  end

  def test_is_verb
    assert @dic.is_verb?( "quit" )
    assert @dic.is_verb?( "QUIT" )
    assert @dic.is_verb?( "quIT" )
    refute @dic.is_verb?( "XXXX" )
    refute @dic.is_verb?( "" )
    refute @dic.is_verb?( nil )
  end
  
  def test_find_a_verb
    assert @dic.find_verb( "quit" )
    assert @dic.find_verb( "QUIT" )
    refute @dic.find_verb( nil )
    refute @dic.find_verb( "" )
    refute @dic.find_verb( "XXX" )
  end
  
end
