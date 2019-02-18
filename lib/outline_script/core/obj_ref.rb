# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An object reference.
# A string that points to an object in the heap.
# The referenced object might or might not exist (yet).
#

module OutlineScript
  module Core
    class ObjRef
      
      attr_reader :raw
      
      # Set up the object.
      def initialize( raw_value = nil )
        @raw = raw_value
      end
      
      # Reference to the root object path.
      def self.root
        return ObjRef.new( "root" )
      end
      
    end
  end
end
