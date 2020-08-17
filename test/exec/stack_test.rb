require 'test_helper'

class StackTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_debug_file
    o = Gloo::Exec::Stack.new 'test'
    assert o
    assert o.out_file.start_with? $settings.debug_path
    assert o.out_file.end_with? 'test'
  end

  def test_pushing_poping
    o = Gloo::Exec::Stack.new 'test'
    assert o
    assert_equal 0, o.size

    o.push Gloo::Verbs::Run.new( nil )
    assert_equal 1, o.size
    o.pop
    assert_equal 0, o.size
  end

  def test_getting_out_data
    o = Gloo::Exec::Stack.new 'test'
    assert_equal '', o.out_data

    o.push Gloo::Verbs::Run.new( nil )
    assert_equal 'run', o.out_data
  end

end
