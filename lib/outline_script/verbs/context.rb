# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Set the current context pointer.
# Alternatively if no value is provided, just show the context.
#

module OutlineScript
  module Verbs
    class Context < OutlineScript::Core::Verb
      
      KEYWORD = 'context'
      KEYWORD_SHORT = '@'

      # 
      # Run the verb.
      # 
      def run
        if @tokens.token_count == 1
          show_context
        else
          path = @tokens.second
          $engine.heap.context.set_to path
          $engine.heap.it.set_to path
          $log.debug "Context set to #{$engine.heap.context}"
        end
      end
      
      # 
      # Show the current context.
      # 
      def show_context
        $log.show "Context:  #{$engine.heap.context}"
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
