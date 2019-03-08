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
        @symbols = []
      end
      
      # Evaluate the expression and return the value.
      def evaluate
        identify_tokens
        
        # TODO: evaluate all symbols
        return @symbols.first.value
      end
      
      # Identify each token in the list.
      def identify_tokens
        @tokens.each do |o|
          @symbols << identify_token( o )
        end
      end
      
      # 
      # Identify the tokens and create appropriate symbols.
      # 
      def identify_token token
        return LiteralString.new( token ) if token.start_with?( '"' )
      end
      
    end
  end
end
