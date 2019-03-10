# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An Expression that can be evaluated.
#

module OutlineScript
  module Expr
    class LString < OutlineScript::Core::Literal
            
      # Set the value, triming opening and closing
      # quotations if necessary.
      def set_value value
        @value = value
        return unless value
        if @value.start_with?( '"' )
          @value = @value[ 1..-1 ]
        end
        if @value.end_with?( '"' )
          @value = @value[ 0..-2 ]
        end        
      end
      
      # Is the given token a string?
      def self.is_string? token
        return false unless token.is_a? String
        return token.start_with?( '"' )
      end
      
      def to_s
        return self.value
      end
      
    end
  end
end
