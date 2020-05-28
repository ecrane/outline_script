# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An Untyped Object.
#

module Gloo
  module Objs
    class Untyped < Gloo::Core::Obj

      KEYWORD = 'untyped'.freeze
      KEYWORD_SHORT = 'un'.freeze

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

      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      #
      # Get a list of message names that this object receives.
      #
      def self.messages
        return super # + [ "run" ]
      end

      # ---------------------------------------------------------------------
      #    Help
      # ---------------------------------------------------------------------

      #
      # Get help for this object type.
      #
      def self.help
        return <<~TEXT
          UNTYPED OBJECT TYPE
            NAME: untyped
            SHORTCUT: un

          DESCRIPTION
            An untyped object.
            If no type is specified when an object is created it
            will be of this type.

          CHILDREN
            None

          MESSAGES
            None
        TEXT
      end

    end
  end
end
