# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Show a single object's value.
#

module Gloo
  module Verbs
    class Show < Gloo::Core::Verb
      
      KEYWORD = 'show'
      KEYWORD_SHORT = '='

      # 
      # Run the verb.
      # 
      def run
        if @tokens.token_count > 1
          expr = Gloo::Expr::Expression.new( @tokens.params )
          result = expr.evaluate
          $log.show result
          $engine.heap.it.set_to result
        else
          $log.show ""
        end
      end
                
      # 
      # Get the Verb's keyword.
      # 
      def self.keyword
        return KEYWORD
      end

      # 
      # Get the Verb's keyword shortcut.
      # 
      def self.keyword_shortcut
        return KEYWORD_SHORT
      end

    end
  end
end
