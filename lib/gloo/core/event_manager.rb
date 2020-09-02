# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# The Event Manager.
# Run scripts in response to pre-defined events.
#

module Gloo
  module Core
    class EventManager

      #
      # Set up the event manager.
      #
      def initialize
        $log.debug 'event manager intialized...'
      end

      #
      # Run on_load scripts in the recently loaded object
      # If no obj is given the script will be run in root.
      #
      def on_load( obj = nil, in_heap = false )
        return unless obj || in_heap

        $log.debug 'on_load event'
        arr = Gloo::Core::ObjFinder.by_name 'on_load', obj
        arr.each { |o| Gloo::Exec::Dispatch.message 'run', o }
      end

      #
      # Run on_unload scripts in the object that will be unloaded.
      #
      def on_unload( obj )
        return unless obj

        $log.debug 'on_unload event'
        arr = Gloo::Core::ObjFinder.by_name 'on_unload', obj
        arr.each { |o| Gloo::Exec::Dispatch.message 'run', o }
      end

    end
  end
end
