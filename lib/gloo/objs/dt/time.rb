# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# A Time object (does not include a date).
#

module Gloo
  module Objs
    class Time < Gloo::Core::Obj

      KEYWORD = 'time'.freeze
      KEYWORD_SHORT = 'time'.freeze

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
        t = DateTime.now.strftime( '%I:%M:%S %P' )
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
          TIME OBJECT TYPE
            NAME: time
            SHORTCUT: time

          DESCRIPTION
            A reference to a time, but without a date.

          CHILDREN
            None

          MESSAGES
            now - Set to the current system time.
        TEXT
      end

    end
  end
end
