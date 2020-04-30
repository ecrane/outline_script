require 'test_helper'

class DictionaryTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
    @dic = Gloo::Core::Dictionary.instance
  end

  def test_dictionary_constrution
    assert @dic
  end

  def test_obj_list
    assert @dic.objs
    assert ( @dic.objs.count > 0 )
  end

  def test_is_obj
    assert @dic.is_obj?( "string" )
    refute @dic.is_obj?( "XXXX" )
    refute @dic.is_obj?( '' )
    refute @dic.is_obj?( nil )
  end
  
  def test_find_an_obj
    assert @dic.find_obj( "string" )
    assert @dic.find_obj( "STRING" )
    refute @dic.find_obj( nil )
    refute @dic.find_obj( '' )
    refute @dic.find_obj( "XXX" )
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
    refute @dic.is_verb?( '' )
    refute @dic.is_verb?( nil )
  end
  
  def test_find_a_verb
    assert @dic.find_verb( "quit" )
    assert @dic.find_verb( "QUIT" )
    refute @dic.find_verb( nil )
    refute @dic.find_verb( '' )
    refute @dic.find_verb( "XXX" )
  end
  
  def test_getting_verbs_sorted
    verbs = @dic.get_verbs
    assert verbs
    assert verbs.count > 5
  end

  def test_getting_obj_types_sorted
    objs = @dic.get_obj_types
    assert objs
    assert objs.count > 4
  end
  
end
