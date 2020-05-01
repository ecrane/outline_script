require 'test_helper'

class OpPlusTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_adding_two_numbers
    @engine.parser.run '= 2 + 3'
    assert_equal 5, @engine.heap.it.value
  end

  def test_adding_three_numbers
    @engine.parser.run '= 2 + 3 + 12'
    assert_equal 17, @engine.heap.it.value
  end

  def test_adding_two_numbers_with_default_op
    @engine.parser.run '= 4 3'
    assert_equal 7, @engine.heap.it.value
  end

end
