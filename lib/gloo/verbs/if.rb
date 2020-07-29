# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# If something is true, do something.
#

module Gloo
  module Verbs
    class If < Gloo::Core::Verb

      KEYWORD = 'if'.freeze
      KEYWORD_SHORT = 'if'.freeze
      THEN = 'then'.freeze

      #
      # Run the verb.
      #
      def run
        value = @tokens.before_token( THEN )
        if value.count > 1
          # The first token is the verb, so we drop it.
          value = value[ 1..-1 ]
        end

        evals_true = false
        if value.count.positive?
          expr = Gloo::Expr::Expression.new( value )
          result = expr.evaluate
          evals_true = true if result == true
          evals_true = true if result.is_a?( Numeric ) && result != 0
        end
        return unless evals_true

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
          IF VERB
            NAME: if
            SHORTCUT: if

          DESCRIPTION
            If an expression is true then do something.

          SYNTAX
            if <true> then <do>

          PARAMETERS
            true - Does the expression evaluate to true?
            do - Execute command if the expression is true.

          RESULT
            Unchanged if the expression is not true.
            If true, then the result will be based on the command
            specified after the 'then' keyword.

          ERRORS
            The errors depend on the object that is run.
        TEXT
      end

    end
  end
end
