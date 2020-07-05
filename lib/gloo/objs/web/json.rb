# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# JSON data.
#
require 'json'

module Gloo
  module Objs
    class Json < Gloo::Core::Obj

      KEYWORD = 'json'.freeze
      KEYWORD_SHORT = 'json'.freeze

      #
      # The name of the object type.
      #
      def self.typename
        return KEYWORD
      end

      #
      # The short name of the object type.
      #
      def self.short_typename
        return KEYWORD_SHORT
      end

      #
      # Set the value with any necessary type conversions.
      #
      def set_value( new_value )
        self.value = new_value.to_s
      end

      #
      # Does this object support multi-line values?
      # Initially only true for scripts.
      #
      def multiline_value?
        return false
      end

      #
      # Get the number of lines of text.
      #
      def line_count
        return value.split( "\n" ).count
      end

      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      #
      # Get a list of message names that this object receives.
      #
      def self.messages
        return super + %w[get]
      end

      #
      # Get a value from the JSON data.
      #
      def msg_get
        if @params&.token_count&.positive?
          expr = Gloo::Expr::Expression.new( @params.tokens )
          data = expr.evaluate
        end
        return unless data

        h = JSON.parse( self.value )
        field = h[ data ]
        $engine.heap.it.set_to field
        return field
      end

      # ---------------------------------------------------------------------
      #    Help
      # ---------------------------------------------------------------------

      #
      # Get help for this object type.
      #
      def self.help
        return <<~TEXT
          JSON OBJECT TYPE
            NAME: json
            SHORTCUT: json

          DESCRIPTION
            JSON data in a text string.

          CHILDREN
            None

          MESSAGES
            None
        TEXT
      end

    end
  end
end
