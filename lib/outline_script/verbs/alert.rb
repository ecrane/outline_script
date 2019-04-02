# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Show a system notification.
#

module OutlineScript
  module Verbs
    class Alert < OutlineScript::Core::Verb
      
      # 
      # Run the verb.
      # 
      def run
        if @tokens.token_count > 1
          expr = OutlineScript::Expr::Expression.new( @tokens.params )
          result = expr.evaluate
          $engine.heap.it.set_to result
          system( '/usr/bin/osascript -e "display notification \"' + result.to_s + '\" with title \"OutlineScript\" "' ) 
        end
      end
                
      # 
      # Get the Verb's keyword.
      # 
      def self.keyword
        return 'alert'
      end

      # 
      # Get the Verb's keyword shortcut.
      # 
      def self.keyword_shortcut
        return ''
      end

    end
  end
end
