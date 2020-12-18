require 'test_helper'

class StatsTest < Minitest::Test

  def test_that_stats_are_not_valid_without_dir
    o = Gloo::Utils::Stats.new "", ''
    assert o
    refute o.valid?
  end

  def test_that_stats_are_not_valid_without_root_dir
    o = Gloo::Utils::Stats.new "bla bla", ''
    assert o
    refute o.valid?
  end

  def test_that_stats_are_valid_for_home_dir
    o = Gloo::Utils::Stats.new $settings.project_path, ''
    assert o
    assert o.valid?
  end

end
