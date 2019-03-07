# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An Expression that can be evaluated.
#

module OutlineScript
  module Expr
    class Expression
      
      # Create the expression from a list of tokens.
      def initialize tokens
        @tokens = tokens
      end
      
      # Evaluate the expression and return the value.
      def evaluate
        
      end
      
    end
  end
end
