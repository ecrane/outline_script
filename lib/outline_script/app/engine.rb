# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# The Outline Script Engine.
#

module OutlineScript
  module App
    class Engine

      attr_reader :mode
      
      # Set up the engine with basic elements.
      def initialize
        $engine = self
        $settings = Settings.new
        $log = Log.new
        $log.debug "engine intialized..."
      end
      
      # Start the engine.
      def start
        $log.debug "starting the engine..."
        $log.debug Info.display_title
        detect_mode
      end
      
      # Detect the mode to be run in.
      def detect_mode
        @mode = Mode::EMBED
        $log.debug "running in #{@mode} mode"
      end
      
    end
  end
end
