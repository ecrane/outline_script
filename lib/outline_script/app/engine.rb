# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# The Outline Script Engine.
#

module OutlineScript
  module App
    class Engine

      attr_reader :args, :mode
      
      # Set up the engine with basic elements.
      def initialize( params = [] )
        $engine = self
        @args = Args.new( params )
        $settings = Settings.new
        $log = Log.new
        $log.debug "engine intialized..."
      end
      
      # Start the engine.
      def start
        $log.debug "starting the engine..."
        $log.debug Info.display_title
        @mode = @args.detect_mode
      end
      
      
    end
  end
end
