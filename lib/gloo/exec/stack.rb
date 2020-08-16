# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# The running object stack.
#

module Gloo
  module Exec
    class Stack

      VERB_DEBUG = 'verb'.freeze

      #
      # Set up the stack.
      #
      def initialize
        $log.debug 'stack intialized...'

        @verbs = []
        update_stack
      end

      #
      # Push a verb onto the stack.
      #
      def vpush( verb )
        $log.debug "push #{verb.type_display}"
        @verbs.push verb
        update_stack
      end

      #
      # Pop a verb from the stack.
      #
      def vpop
        v = @verbs.pop
        $log.debug "pop #{v.type_display}"
        update_stack
      end

      #
      # Get Verb stack data.
      #
      def verb_data
        return @verbs.map( &:type_display ).join( "\n" )
      end

      #
      # Get the file we'll write debug information to for the verb stack.
      #
      def verb_debug_file
        return File.join( $settings.debug_path, VERB_DEBUG )
      end

      #
      # Update the stack trace file.
      #
      def update_stack
        File.write( verb_debug_file, verb_data )
      end

    end
  end
end
