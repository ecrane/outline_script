# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An object with an integer value.
#

module Gloo
  module Objs
    class Integer < Gloo::Core::Obj
      
      KEYWORD = 'integer'
      KEYWORD_SHORT = 'int'

      # 
      # The name of the object type.
      # 
      def self.typename
        return KEYWORD
      end

      # 
      # The short name of the object type.
      # 
      def self.short_typename
        return KEYWORD_SHORT
      end

      # 
      # Set the value with any necessary type conversions.
      # 
      def set_value new_value
        self.value = new_value.to_i
      end
      
      
      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      # 
      # Get a list of message names that this object receives.
      # 
      def self.messages
        return super # + [ "run" ]
      end


    end
  end
end
