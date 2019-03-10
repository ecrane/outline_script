# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# A Literal value.
#

module OutlineScript
  module Core
    class Literal
      
      attr_reader :value
      
      # Create the expression from a list of tokens.
      def initialize value
        set_value( value )
      end
      
      # Set the literal value.
      def set_value value
        @value = value
      end      
      
    end
  end
end
