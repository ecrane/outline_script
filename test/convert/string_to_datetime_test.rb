require 'test_helper'

class StringToDateTimeTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_conversion
    o = Gloo::Convert::StringToDateTime.new
    assert o
    dt = DateTime.now
    assert_equal dt.strftime( '%Y.%m.%d' ), o.convert( 'now' ).strftime( '%Y.%m.%d' )
  end

  def test_with_engine
    v = @engine.parser.parse_immediate 'create dt as datetime'
    v.run
    dt = @engine.heap.root.children.first

    v = @engine.parser.parse_immediate "put 'now' into dt"
    v.run
    assert dt.value
    str = dt.value.strftime( '%Y.%m.%d' )
    assert str
    assert_equal DateTime.now.strftime( '%Y.%m.%d' ), str
  end

end
