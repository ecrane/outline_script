# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# The Runner is a static helper function.
# It is used to send the run command to verbs.
#

module Gloo
  module Exec
    class Runner

      #
      # Dispatch run command to a verb.
      # We abstract this out in case there are things
      # that need to be done before or after a verb
      # is done running.
      #
      def self.go( verb )
        $log.debug "**** Running verb #{verb.type_display}"
        $engine.heap.error.start_tracking
        verb&.run
        $engine.heap.error.clear_if_no_errors
      end

      #
      # Send 'run' message to the object.
      # Resolve the path_name and then send the run message.
      #
      def self.run( path_name )
        $log.debug "**** Running script at #{path_name}"
        pn = Gloo::Core::Pn.new path_name
        o = pn.resolve

        if o
          o.send_message 'run'
        else
          $log.error "Could not send message to object.  Bad path: #{path_name}"
        end
      end

    end
  end
end
