# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# A String.
#

module OutlineScript
  module Objs
    class String < OutlineScript::Core::Obj
      
      
      # 
      # The name of the object type.
      # 
      def self.typename
        return "string"
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
