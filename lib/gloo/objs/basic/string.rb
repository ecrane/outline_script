# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# A String.
#

module Gloo
  module Objs
    class String < Gloo::Core::Obj

      KEYWORD = 'string'.freeze
      KEYWORD_SHORT = 'str'.freeze

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

      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      #
      # Get a list of message names that this object receives.
      #
      def self.messages
        return super + %w[up down]
      end

      # Convert string to upper case
      def msg_up
        s = value.upcase
        set_value s
        $engine.heap.it.set_to s
        return s
      end

      # Convert string to lower case
      def msg_down
        s = value.downcase
        set_value s
        $engine.heap.it.set_to s
        return s
      end

      # ---------------------------------------------------------------------
      #    Help
      # ---------------------------------------------------------------------

      #
      # Get help for this object type.
      #
      def self.help
        return <<~TEXT
          OBJECT TYPE
          \tNAME: string
          \tSHORTCUT: str

          DESCRIPTION
          \tA string value.

          CHILDREN
          \t<none>

          MESSAGES
          \tup \t - Convert the string to uppercase.
          \tdown \t - Convert the string to lowercase.

        TEXT
      end

    end
  end
end
