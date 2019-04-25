# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# A script to be run.
#

module Gloo
  module Core
    class Script
      
      # Set up the script.
      def initialize obj
        @obj = obj
      end
      
      
      # Run the script.
      def run
        i = $engine.parser.parse_immediate @obj.value
        i.run
      end
      
    end
  end
end
