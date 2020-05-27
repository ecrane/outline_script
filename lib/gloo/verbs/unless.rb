# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# If something is false, do something.
#

module Gloo
  module Verbs
    class Unless < Gloo::Core::Verb

      KEYWORD = 'unless'.freeze
      KEYWORD_SHORT = 'if!'.freeze
      THEN = 'do'.freeze

      #
      # Run the verb.
      #
      def run
        value = @tokens.before_token( THEN )
        if value.count > 1
          # The first token is the verb, so we drop it.
          value = value[ 1..-1 ]
        end

        evals_false = false
        if value.count.positive?
          expr = Gloo::Expr::Expression.new( value )
          result = expr.evaluate
          evals_false = true if result == false
        end
        return unless evals_false

        cmd = @tokens.expr_after( THEN )
        i = $engine.parser.parse_immediate cmd
        return unless i

        i.run
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
          UNLESS VERB
            NAME: unless
            SHORTCUT: if!

          DESCRIPTION
            Unless an expression is true, do something.
            This is the opposite of the if verb.

          SYNTAX
            unless <true> do <do>

          PARAMETERS
            true - Does the expression evaluate to true?
            do - Execute command if the expression is not true.

          RESULT
            Unchanged if the expression is true.
            If not true, then the result will be based on the command
            specified after the 'do' keyword.

          ERRORS
            The errors depend on the object that is run.
        TEXT
      end

    end
  end
end
