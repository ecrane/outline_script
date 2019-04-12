require "test_helper"

class BaseoTest < Minitest::Test
  
  def setup
    @engine = Gloo::App::Engine.new( [ "--quiet" ] )
  end
  
  def test_that_all_objects_have_names
    o = Gloo::Core::Baseo.new
    assert o
    assert o.name
  end

  
end
