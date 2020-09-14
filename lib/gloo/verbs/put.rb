# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Create an object, optionally of a type.
#

module Gloo
  module Verbs
    class Put < Gloo::Core::Verb

      KEYWORD = 'put'.freeze
      KEYWORD_SHORT = 'p'.freeze
      INTO = 'into'.freeze

      #
      # Run the verb.
      #
      def run
        value = fetch_value_tokens
        return if value.nil?

        target = lookup_target
        return if target.nil?

        pn = Gloo::Core::Pn.new target
        o = pn.resolve
        if o.nil?
          msg = "could not find target of put: #{target}"
          $log.error msg, nil, $engine
        elsif value.count.positive?
          expr = Gloo::Expr::Expression.new( value )
          result = expr.evaluate
          o.set_value result
          $engine.heap.it.set_to result
        end
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
      #    Helper functions
      # ---------------------------------------------------------------------

      # Get the value that is being put.
      def fetch_value_tokens
        value = @tokens.before_token( INTO )
        if value.nil?
          msg = "'put' must include 'into'"
          $log.error msg, nil, $engine
          return nil
        end

        if value.count > 1
          # The first token is the verb, so we drop it.
          value = value[ 1..-1 ]
        end
        return value
      end

      # Lookup the target of the put command.
      def lookup_target
        target = @tokens.after_token( INTO )
        return target if target

        msg = "'put' must include 'into' target"
        $log.error msg, nil, $engine
        return nil
      end

    end
  end
end
