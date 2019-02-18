# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Set the current context pointer.
# Alternatively if no value is provided, just show the context.
#

module OutlineScript
  module Verbs
    class Context < OutlineScript::Core::Verb
      
      # 
      # Run the verb.
      # 
      def run
        puts "context"
      end
      
      # 
      # Get the Verb's keyword.
      # 
      def self.keyword
        return 'context'
      end

      # 
      # Get the Verb's keyword shortcut.
      # 
      def self.keyword_shortcut
        return '@'
      end

    end
  end
end
