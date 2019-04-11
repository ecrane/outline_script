# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An Untyped Object.
#

module OutlineScript
  module Objs
    class Untyped < OutlineScript::Core::Obj
      
      KEYWORD = 'untyped'
      KEYWORD_SHORT = 'un'

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

    end
  end
end
