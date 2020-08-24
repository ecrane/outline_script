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
    assert @dic.objs.count.positive?
  end

  def test_is_obj
    assert @dic.obj?( 'string' )
    refute @dic.obj?( 'XXXX' )
    refute @dic.obj?( '' )
    refute @dic.obj?( nil )
  end

  def test_find_an_obj
    assert @dic.find_obj( 'string' )
    assert @dic.find_obj( 'string' )
    refute @dic.find_obj( nil )
    refute @dic.find_obj( '' )
    refute @dic.find_obj( 'XXX' )
  end

  def test_verb_list
    assert @dic.verbs
    assert @dic.verbs.count.positive?
  end

  def test_is_verb
    assert @dic.verb?( 'quit' )
    assert @dic.verb?( 'QUIT' )
    assert @dic.verb?( 'quIT' )
    refute @dic.verb?( 'XXXX' )
    refute @dic.verb?( '' )
    refute @dic.verb?( nil )
  end

  def test_find_a_verb
    assert @dic.find_verb( 'quit' )
    assert @dic.find_verb( 'QUIT' )
    refute @dic.find_verb( nil )
    refute @dic.find_verb( '' )
    refute @dic.find_verb( 'XXX' )
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

  def test_keyword_lookup
    refute @dic.lookup_keyword( 'aaabbbccc' )
    refute @dic.lookup_keyword( 'blark' )
    refute @dic.lookup_keyword( '' )

    assert_equal 'quit', @dic.lookup_keyword( 'quit' )
    assert_equal 'quit', @dic.lookup_keyword( 'q' )
    assert_equal 'quit', @dic.lookup_keyword( 'QUIT' )

    assert_equal 'string', @dic.lookup_keyword( 'STRING' )
    assert_equal 'string', @dic.lookup_keyword( 'STR' )
    assert_equal 'string', @dic.lookup_keyword( 'str' )
  end

end
