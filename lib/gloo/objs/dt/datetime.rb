# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# A Date and Time object.
#

module Gloo
  module Objs
    class Datetime < Gloo::Core::Obj

      KEYWORD = 'datetime'.freeze
      KEYWORD_SHORT = 'dt'.freeze

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
        return super + %w[now]
      end

      # Get the current working branch.
      def msg_now
        t = DateTime.now.strftime( '%Y.%m.%d %I:%M:%S %P' )
        self.value = t
        $engine.heap.it.set_to t
      end

      # ---------------------------------------------------------------------
      #    Help
      # ---------------------------------------------------------------------

      #
      # Get help for this object type.
      #
      def self.help
        return <<~TEXT
          DATETIME OBJECT TYPE
            NAME: datetime
            SHORTCUT: dt

          DESCRIPTION
            A reference to a date and time.

          CHILDREN
            None

          MESSAGES
            now - Set to the current system date and time.
        TEXT
      end

    end
  end
end
