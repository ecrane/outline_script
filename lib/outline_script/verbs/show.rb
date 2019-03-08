# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Show a single object's value.
#

module OutlineScript
  module Verbs
    class Show < OutlineScript::Core::Verb
      
      # 
      # Run the verb.
      # 
      def run
        if @tokens.token_count > 1
          expr = OutlineScript::Expr::Expression.new( @tokens.params )
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
        return 'show'
      end

      # 
      # Get the Verb's keyword shortcut.
      # 
      def self.keyword_shortcut
        return ','
      end

    end
  end
end
