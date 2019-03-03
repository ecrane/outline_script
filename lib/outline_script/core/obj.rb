# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An data/value object.
# Derives from the Baseo object.  Is not a verb.
#

module OutlineScript
  module Core
    class Obj < Baseo
      
      attr_accessor :value
      attr_reader :children

      # Set up the object.
      def initialize()
        @value = ""
        @children = []
      end
        
      # Register object types when they are loaded.
      def self.inherited( subclass )
        Dictionary.instance.register_obj( subclass )
      end

      # 
      # The name of the object type.
      # 
      def self.typename
        raise 'this method should be overriden'
      end
    
    end
  end
end
