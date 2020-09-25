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

      #
      # Set to the current time.
      #
      def msg_now
        t = DateTime.now.strftime( '%I:%M:%S %P' )
        self.value = t
        $engine.heap.it.set_to t
      end

    end
  end
end
