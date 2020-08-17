# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# A script to be run.
#

module Gloo
  module Exec
    class Script

      #
      # Set up the script.
      #
      def initialize( obj )
        @obj = obj
      end

      #
      # Run the script.
      # The script might be a single string or an array
      # of lines.
      #
      def run
        $engine.exec_env.scripts.push self

        if @obj.value.is_a? String
          $engine.parser.run @obj.value
        elsif @obj.value.is_a? Array
          @obj.value.each do |line|
            $engine.parser.run line
          end
        end

        $engine.exec_env.scripts.pop
      end

      #
      # Generic function to get display value.
      # Can be used for debugging, etc.
      #
      def display_value
        return @obj.pn
      end

    end
  end
end
