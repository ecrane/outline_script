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
          evals_false = true if result.is_a?( Numeric ) && result.zero?
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

    end
  end
end
