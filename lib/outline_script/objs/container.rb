# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An object that contains a collection of other objects.
#

module OutlineScript
  module Objs
    class Container < OutlineScript::Core::Obj
      
      
      # 
      # The name of the object type.
      # 
      def self.typename
        return "container"
      end

    end
  end
end
