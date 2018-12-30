# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# The Outline Script Engine.
#

require 'colorize'

module OutlineScript
  module App
    class Engine

      # Set up the engine with basic elements.
      def initialize
        $settings = Settings.new
        $log = Log.new
        $log.debug "engine intialized..."
      end
      
      # Start the engine.
      def start
        $log.debug "starting the engine..."
        $log.info Info.display_title
      end
      
    end
  end
end
