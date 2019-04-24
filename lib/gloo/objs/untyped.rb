# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An Untyped Object.
#

module Gloo
  module Objs
    class Untyped < Gloo::Core::Obj
      
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

      # 
      # Get a list of message names that this object receives.
      # 
      def self.messages
        return super # + [ "run" ]
      end

    end
  end
end
