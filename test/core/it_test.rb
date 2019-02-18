require "test_helper"

class ItTest < Minitest::Test
  
  def setup
    @engine = OutlineScript::App::Engine.new( [ "--quiet" ] )
  end

  def test_it_constrution
    o = OutlineScript::Core::It.new
    assert o
    refute o.value
  end

  
end
