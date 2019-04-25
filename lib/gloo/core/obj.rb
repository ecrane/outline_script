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
      attr_reader :children, :parent

      # Set up the object.
      def initialize()
        @value = ""
        @children = []
        @parent = nil
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
      
      # 
      # Set the parent for the object.
      # 
      def set_parent obj
        @parent = obj
      end
      

      # ---------------------------------------------------------------------
      #    Children
      # ---------------------------------------------------------------------
      
      # Add a child object to the container.
      def add_child obj
        @children << obj
        obj.set_parent self
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
      
      # Remove the object from the children collection.
      def remove_child obj
        @children.delete obj
      end
      
      
      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      # 
      # Get a list of message names that this object receives.
      # 
      def self.messages
        return [ "unload" ]
      end
      
      # 
      # Can this object receive a message?
      # 
      def can_receive_message? msg
        msgs = self.class.messages
        return msgs.include?( msg.strip.downcase )
      end

      # 
      # Sent this object the given message.
      # 
      def send_message msg
        if self.can_receive_message? msg
          return self.dispatch msg
        else
          $log.error "Object #{self.name} cannot receive message #{msg}"
          return false
        end
      end
      
      # 
      # Dispatch the message to the object.
      # 
      def dispatch msg
        o = "msg_#{msg}"
        if self.respond_to? o 
          self.public_send( o ) 
          return true
        else
          $log.error "Message #{msg} not implemented"
          return false
        end
      end
      
      # 
      # Send the object the unload message.
      # 
      def msg_unload
        $engine.heap.unload self
      end
      
    end
  end
end
