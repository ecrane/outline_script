# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An Expression that can be evaluated.
#

module OutlineScript
  module Expr
    class LiteralString
      
      attr_reader :value
      
      # Create the expression from a list of tokens.
      def initialize value
        set_value( value )
      end
      
      # Set the value, triming opening and closing
      # quotations if necessary.
      def set_value value
        @value = value
        if @value.start_with?( '"' )
          @value = @value[ 1..-1 ]
        end
        if @value.end_with?( '"' )
          @value = @value[ 0..-2 ]
        end        
      end
    end
  end
end
