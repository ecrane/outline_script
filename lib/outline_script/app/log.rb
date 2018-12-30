# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Application Logging wrapper.
#
require 'active_support'
require 'colorize'

module OutlineScript
  module App
    class Log

      attr_reader :logger
      
      def initialize()
        f = File.join( $settings.log_path, "outline_script.log" )
        @logger = Logger.new( f )
        @logger.level = Logger::DEBUG
      end
      
      def debug msg
        @logger.debug msg
      end

      def info msg
        @logger.info msg
        puts msg.blue
      end

      def warn msg
        @logger.warn msg
        puts msg.yellow
      end

      def error msg, e = nil
        if e
          @logger.error msg
          @logger.error e.message
          @logger.error e.backtrace
          puts msg.red
          puts e.message.red
          puts e.backtrace
        else
          @logger.error msg
          puts msg.red
        end
      end  

    end
  end
end
