# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# A script to be run.
#

module Gloo
  module Core
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
        if @obj.value.is_a? String
          $engine.parser.run @obj.value
        elsif @obj.value.is_a? Array
          @obj.value.each do |line|
            $engine.parser.run line
          end
        end
      end

    end
  end
end
