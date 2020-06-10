require 'test_helper'

class FileSaverTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_getting_simple_object
    o = @engine.factory.create(
      { :name => 's', :type => 'str', :value => 'one' } )
    assert o

    fs = Gloo::Persist::FileSaver.new( '', nil )
    assert fs

    str = fs.get_obj o
    assert_equal "s [string] : one\n", str
  end

  def test_tabs
    fs = Gloo::Persist::FileSaver.new( '', nil )

    assert_equal '', fs.tabs
    assert_equal '', fs.tabs( 0 )
    assert_equal "\t", fs.tabs( 1 )
    assert_equal "\t\t", fs.tabs( 2 )
  end

end
