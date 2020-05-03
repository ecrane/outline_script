# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# A Script.
# A set of commands to be run.
#

module Gloo
  module Objs
    class Script < Gloo::Core::Obj

      KEYWORD = 'script'.freeze
      KEYWORD_SHORT = 'cmd'.freeze

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
      def set_value new_value
        self.value = new_value.to_s
      end

      #
      # Set the value as an array.
      #
      def set_array_value arr
        self.value = arr
      end

      #
      # Add a line (cmd) to the script.
      #
      def add_line line
        if self.value_is_string?
          first = self.value
          self.set_array_value []
          self.value << first unless first.empty?
        elsif self.value_is_blank?
          self.set_array_value []
        end
        self.value << line.strip
      end

      #
      # Does this object support multi-line values?
      # Initially only true for scripts.
      #
      def has_multiline_value?
        return true
      end

      #
      # Get the number of lines in this script.
      #
      def line_count
        if self.value_is_array?
          return self.value.count
        elsif self.value_is_string?
          return 0 if ( self.value.strip.empty? )
          return 1
        else
          return 0
        end
      end


      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      #
      # Get a list of message names that this object receives.
      #
      def self.messages
        return super + [ "run" ]
      end

      #
      # Send the object the unload message.
      #
      def msg_run
        s = Gloo::Core::Script.new self
        s.run
      end

    end
  end
end
