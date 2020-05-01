require 'test_helper'

class OpDivTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_dividing_two_numbers
    @engine.parser.run '= 6 / 3'
    assert_equal 2, @engine.heap.it.value
  end

  def test_dividing_three_numbers
    @engine.parser.run '= 12 / 3 / 2'
    assert_equal 2, @engine.heap.it.value
  end

end
