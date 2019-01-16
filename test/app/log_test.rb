require "test_helper"

class LogTest < Minitest::Test
  
  def test_creation
    OutlineScript::App::Engine.new( [ "--quiet" ] )
    assert $log
  end
  
  def test_default_logger
    OutlineScript::App::Engine.new( [ "--quiet" ] )
    assert $log.logger
    assert_equal Logger::DEBUG, $log.logger.level
  end

  def test_quiet_logging
    OutlineScript::App::Engine.new( [ "--quiet" ] )
    assert $log.quiet
  end
  
  def test_noisy_logging
    OutlineScript::App::Engine.new
    refute $log.quiet
  end
  
  def test_debug
    OutlineScript::App::Engine.new( [ "--quiet" ] )
    $log.debug "debug statement"
  end

  def test_info
    OutlineScript::App::Engine.new( [ "--quiet" ] )
    $log.info "info statement"
  end

  def test_warn
    OutlineScript::App::Engine.new( [ "--quiet" ] )
    $log.warn "warn statement"
  end
  
  def test_error
    OutlineScript::App::Engine.new( [ "--quiet" ] )
    $log.error "error statement"
  end
  
end
