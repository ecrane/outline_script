# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# A script to be run.
#

module Gloo
  module Core
    class Script

      # Set up the script.
      def initialize( obj )
        @obj = obj
      end

      # Run the script.
      def run
        if @obj.value.is_a? String
          run_line @obj.value
        elsif @obj.value.is_a? Array
          @obj.value.each do |line|
            run_line line
          end
        end
      end

      # Run a single line of the script.
      def run_line( line )
        i = $engine.parser.parse_immediate line
        return unless i

        i.run
      end

    end
  end
end
