require 'test_helper'

class HelpTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
  end

  def test_help_verb
    @engine.start
    assert @engine.running
    v = Gloo::Verbs::Help.new( nil )
    v.run
    assert @engine.running
  end

  def test_the_keyword
    assert_equal 'help', Gloo::Verbs::Help.keyword
  end

  def test_the_keyword_shortcut
    assert_equal '?', Gloo::Verbs::Help.keyword_shortcut
  end

  def test_looking_up_the_help_option
    v = Gloo::Verbs::Help.new( nil )
    assert_equal 'show_verbs', v.lookup_opts( 'v' )
    assert_equal 'show_verbs', v.lookup_opts( 'verb' )
    assert_equal 'show_verbs', v.lookup_opts( 'verbs' )
    assert_equal 'show_objs', v.lookup_opts( 'o' )
    assert_equal 'show_objs', v.lookup_opts( 'obj' )
    assert_equal 'show_objs', v.lookup_opts( 'objects' )

    refute v.lookup_opts( 'xyz' )
    refute v.lookup_opts( '2342342jsfd' )
  end

end
