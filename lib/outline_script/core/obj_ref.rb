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
      
      # Set the object reference to the given path.
      def set_to path
        @raw = path.strip
      end
      
      # Does the object referenced exists?
      def obj_exists?
        return true if is_root?
        
        return false
      end
      
      # Does the reference refer to the root?
      def is_root?
        return @raw.downcase == "root"
      end
      
      # Get the string representation of the reference.
      def to_s
        return self.raw
      end
      
    end
  end
end
