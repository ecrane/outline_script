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

    end
  end
end
