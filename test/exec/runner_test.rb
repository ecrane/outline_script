require 'test_helper'

class RunnerTest < Minitest::Test

  def setup
    @engine = Gloo::App::Engine.new( [ '--quiet' ] )
    @engine.start
  end

  def test_running_verb
  end

  def test_running_object_at_path
  end

end
