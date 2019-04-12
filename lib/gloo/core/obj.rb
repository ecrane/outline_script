# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An data/value object.
# Derives from the Baseo object.  Is not a verb.
#

module Gloo
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

      # 
      # The object type, suitable for display.
      # 
      def type_display
        return self.class.typename
      end
      
      # 
      # Set the value with any necessary type conversions.
      # 
      def set_value new_value
        self.value = new_value
      end
      
      # 
      # Get the value for display purposes.
      # 
      def value_display
        return self.value.to_s
      end
      
      # Add a child object to the container.
      def add_child obj
        @children << obj
      end
      
      # Get the number of children.
      def child_count
        return @children.count
      end
      
      # Does this object contain an object with the given name?
      def has_child? name
        @children.each do |o|
          return true if ( name.downcase == o.name.downcase )
        end
        return false
      end

      # Find a child object with the given name.
      def find_child name
        @children.each do |o|
          return o if ( name.downcase == o.name.downcase )
        end
        return nil
      end
    
    end
  end
end
