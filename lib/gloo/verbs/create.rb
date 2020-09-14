# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Create an object, optionally of a type.
#

module Gloo
  module Verbs
    class Create < Gloo::Core::Verb

      KEYWORD = 'create'.freeze
      KEYWORD_SHORT = '`'.freeze
      AS = 'as'.freeze
      VAL = ':'.freeze

      #
      # Run the verb.
      #
      def run
        name = @tokens.second
        type = @tokens.after_token( AS )
        value = @tokens.after_token( VAL )

        if Gloo::Expr::LString.string?( value )
          value = Gloo::Expr::LString.strip_quotes( value )
        end
        obj = $engine.factory.create( { name: name, type: type, value: value } )

        obj.add_default_children if obj&.add_children_on_create?
        $engine.heap.it.set_to value
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
