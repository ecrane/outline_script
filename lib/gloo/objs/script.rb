# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# A Script.
# A set of commands to be run.
#

module Gloo
  module Objs
    class Script < Gloo::Core::Obj
      
      KEYWORD = 'script'
      KEYWORD_SHORT = 'cmd'

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
        self.value = new_value.to_s
      end

      
      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      # 
      # Get a list of message names that this object receives.
      # 
      def self.messages
        return super + [ "run" ]
      end

      # 
      # Send the object the unload message.
      # 
      def msg_run
        s = Gloo::Core::Script.new self
        s.run
      end

    end
  end
end
