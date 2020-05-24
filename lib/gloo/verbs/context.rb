# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Set the current context pointer.
# Alternatively if no value is provided, just show the context.
#

module Gloo
  module Verbs
    class Context < Gloo::Core::Verb

      KEYWORD = 'context'.freeze
      KEYWORD_SHORT = '@'.freeze

      #
      # Run the verb.
      #
      def run
        set_context if @tokens.token_count > 1
        show_context
      end

      #
      # Set the context to the given path.
      #
      def set_context
        path = @tokens.second
        $engine.heap.context.set_to path
        $engine.heap.it.set_to path
        $log.debug "Context set to #{$engine.heap.context}"
      end

      #
      # Show the current context.
      #
      def show_context
        $log.show "Context:  #{$engine.heap.context}"
      end

      #
      # Get the Verb's keyword.
      #
      def self.keyword
        return KEYWORD
      end

      #
      # Get the Verb's keyword shortcut.
      #
      def self.keyword_shortcut
        return KEYWORD_SHORT
      end

      # ---------------------------------------------------------------------
      #    Help
      # ---------------------------------------------------------------------

      #
      # Get help for this verb.
      #
      def self.help
        return <<~TEXT
          CONTEXT VERB
            NAME: context
            SHORTCUT: @

          DESCRIPTION
            Get or set the current context.
            When no parameter is provided, the context will be shown.
            Whe the optional path paramter is provided, the context will
            be set to that path.
            Use 'context root' to set the context back to the root level.

          SYNTAX
            context <path.to.new.context>

          PARAMETERS
            path.to.new.context - Optional.  The path to the new context.

          RESULT
            Context is optionally set.
            <it> will be set to the new context path when we are changing context.
            Context is show in either case.

          ERRORS
            None
        TEXT
      end

    end
  end
end
