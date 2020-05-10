# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# If the last command to run generated an error it will be here.
#

module Gloo
  module Core
    class Error

      attr_accessor :value

      # Set up the error object.
      def initialize
        @value = nil
      end

      # Set the value of error.
      def set_to( new_value )
        @value = new_value
      end

      # Clear out the error message.
      def clear
        @value = nil
      end

      # Get the string representation of the error.
      def to_s
        return @value.to_s
      end

    end
  end
end
