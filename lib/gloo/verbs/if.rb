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
          value = value[1..-1]
        end

        evals_true = false
        if value.count.positive?
          expr = Gloo::Expr::Expression.new( value )
          result = expr.evaluate
          evals_true = true if result == true
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

    end
  end
end
