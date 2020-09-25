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

      #
      # Set the value with any necessary type conversions.
      #
      def set_value( new_value )
        unless new_value.is_a? DateTime
          self.value = $engine.converter.convert( new_value, 'DateTime', nil )
          return
        end

        self.value = new_value
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
      # Set to the current date and time.
      #
      def msg_now
        t = DateTime.now.strftime( '%Y.%m.%d %I:%M:%S %P' )
        self.value = t
        $engine.heap.it.set_to t
      end

    end
  end
end
