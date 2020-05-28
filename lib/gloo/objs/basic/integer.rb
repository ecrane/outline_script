# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An object with an integer value.
#

module Gloo
  module Objs
    class Integer < Gloo::Core::Obj

      KEYWORD = 'integer'.freeze
      KEYWORD_SHORT = 'int'.freeze

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
        self.value = new_value.to_i
      end

      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      #
      # Get a list of message names that this object receives.
      #
      def self.messages
        return super + %w[inc dec]
      end

      # Increment the integer
      def msg_inc
        i = value + 1
        set_value i
        $engine.heap.it.set_to i
        return i
      end

      # Decrement the integer
      def msg_dec
        i = value - 1
        set_value i
        $engine.heap.it.set_to i
        return i
      end

      # ---------------------------------------------------------------------
      #    Help
      # ---------------------------------------------------------------------

      #
      # Get help for this object type.
      #
      def self.help
        return <<~TEXT
          INTEGER OBJECT TYPE
            NAME: integer
            SHORTCUT: int

          DESCRIPTION
            An integer (numeric) value.

          CHILDREN
            None

          MESSAGES
            inc - Increment the integer value by 1.
            dec - Decrement the integer value by 1.
        TEXT
      end

    end
  end
end
