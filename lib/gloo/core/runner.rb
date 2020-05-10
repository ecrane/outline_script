# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# The Runner is a static helper function.
# It is used to send the run command to verbs.
#

module Gloo
  module Core
    class Runner

      #
      # Dispatch run command to a verb.
      # We abstract this out in case there are things
      # that need to be done before or after a verb
      # is done running.
      #
      def self.go( verb )
        $engine.heap.error.clear
        verb&.run
      end

    end
  end
end
