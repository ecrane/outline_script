# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An object with an integer value.
#

module OutlineScript
  module Objs
    class Integer < OutlineScript::Core::Obj
      
      
      # 
      # The name of the object type.
      # 
      def self.typename
        return "integer"
      end

    end
  end
end
