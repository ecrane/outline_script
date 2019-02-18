# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# It is the value of the last command that was run.
#

module OutlineScript
  module Core
    class It
      
      attr_accessor :value
      
      # Set up the object.
      def initialize()
        @value = nil
      end
            
    end
  end
end
