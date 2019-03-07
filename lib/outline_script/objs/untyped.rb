# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An Untyped Object.
#

module OutlineScript
  module Objs
    class Untyped < OutlineScript::Core::Obj
      
      
      # 
      # The name of the object type.
      # 
      def self.typename
        return "untyped"
      end

    end
  end
end
