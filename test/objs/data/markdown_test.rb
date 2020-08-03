require 'test_helper'

class MarkdownTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
    @dic = @engine.dictionary
  end

  def test_the_typename
    assert_equal 'markdown', Gloo::Objs::Markdown.typename
  end

  def test_the_short_typename
    assert_equal 'md', Gloo::Objs::Markdown.short_typename
  end

  def test_find_type
    assert @dic.find_obj( 'markdown' )
    assert @dic.find_obj( 'MD' )
  end

  def test_messages
    msgs = Gloo::Objs::Markdown.messages
    assert msgs
    assert msgs.include?( 'show' )
    assert msgs.include?( 'page' )
  end

  def test_adds_children_on_create
    o = Gloo::Objs::Markdown.new
    refute o.add_children_on_create?
  end

  def test_help_text
    assert Gloo::Objs::Markdown.help.start_with? 'MARKDOWN OBJECT TYPE'
  end

end
