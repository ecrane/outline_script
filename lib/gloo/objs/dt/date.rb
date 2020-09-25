# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# A Date object (does not include a time).
#

module Gloo
  module Objs
    class Date < Gloo::Core::Obj

      KEYWORD = 'date'.freeze
      KEYWORD_SHORT = 'date'.freeze

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
      # Set to the current date.
      #
      def msg_now
        t = DateTime.now.strftime( '%Y.%m.%d' )
        self.value = t
        $engine.heap.it.set_to t
      end

    end
  end
end
