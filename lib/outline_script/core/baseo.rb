# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An abstract base object.
# All objects and verbs derive from this.
#

module OutlineScript
  module Core
    class Baseo
      
      attr_accessor :name
      
      # Set up the object.
      def initialize()
        @name = ""
      end
            
    end
  end
end
