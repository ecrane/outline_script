# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An Expression that can be evaluated.
#

module Gloo
  module Expr
    class LString < Gloo::Core::Literal
            
      # Set the value, triming opening and closing
      # quotations if necessary.
      def set_value value
        @value = value
        return unless value
        @value = LString.strip_quotes( @value )
      end
      
      # Is the given token a string?
      def self.is_string? token
        return false unless token.is_a? String
        return true if token.start_with?( '"' )
        return true if token.start_with?( "'" )
        return false
      end

      # 
      # Given a string with leading and trailing quotes,
      # strip them out.
      # 
      def self.strip_quotes str
        if str.start_with?( '"' )
          str = str[ 1..-1 ]
          if str.end_with?( '"' )
            str = str[ 0..-2 ]
          end
          return str
        elsif str.start_with?( "'" )
          str = str[ 1..-1 ]
          if str.end_with?( "'" )
            str = str[ 0..-2 ]
          end
          return str
        end
      end
            
      def to_s
        return self.value
      end
      
    end
  end
end
