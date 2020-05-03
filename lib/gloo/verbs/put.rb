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
        value = @tokens.before_token( INTO )
        if value.nil?
          $log.error "'put' must include 'into'"
          # TODO:  should this return from here?
        end
        if value.count > 1
          # The first token is the verb, so we drop it.
          value = value[1..-1]
        end

        target = @tokens.after_token( INTO )
        if target.nil?
          $log.error "'put' must include 'into' target"
          # TODO:  should this return from here?
        end
        pn = Gloo::Core::Pn.new target
        o = pn.resolve
        if o.nil?
          $log.error "could not find target of put: #{target}"
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

    end
  end
end
