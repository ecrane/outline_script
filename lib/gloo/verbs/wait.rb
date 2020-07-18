# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# Wait for the given number of seconds.
#

module Gloo
  module Verbs
    class Wait < Gloo::Core::Verb

      KEYWORD = 'wait'.freeze
      KEYWORD_SHORT = 'w'.freeze

      #
      # Run the verb.
      #
      def run
        x = 1
        if @tokens.token_count > 1
          expr = Gloo::Expr::Expression.new( @tokens.params )
          x = expr.evaluate.to_i
        end
        sleep x
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
          WAIT VERB
            NAME: wait
            SHORTCUT: w

          DESCRIPTION
            Wait for the given number of seconds.

          SYNTAX
            wait <seconds>

          PARAMETERS
            seconds - The number of seconds.
              If no value is given, we'll wait for 1 second.

          RESULT
            None

          ERRORS
            None
        TEXT
      end

    end
  end
end
