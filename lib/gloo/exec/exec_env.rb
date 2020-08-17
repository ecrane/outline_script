# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# The execution environment.
# The current state of running scripts and messaging.
#

module Gloo
  module Exec
    class ExecEnv

      attr_accessor :verbs, :actions, :scripts

      VERB_STACK = 'verbs'.freeze
      ACTION_STACK = 'actions'.freeze
      SCRIPT_STACK = 'scripts'.freeze

      #
      # Set up the stack.
      #
      def initialize
        $log.debug 'exec env intialized...'

        @verbs = Gloo::Exec::Stack.new VERB_STACK
        @actions = Gloo::Exec::Stack.new ACTION_STACK
        @scripts = Gloo::Exec::Stack.new SCRIPT_STACK
      end

    end
  end
end
