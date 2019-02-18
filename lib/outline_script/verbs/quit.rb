# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Quit the running outline_script engine.
#

module OutlineScript
  module Verbs
    class Quit < OutlineScript::Core::Verb
      
      # 
      # Run the verb.
      # 
      # We'll mark the application as not running and let the
      # engine stop gracefully next time through the loop.
      # 
      def run
        $engine.stop_running
      end
      
      # 
      # Get the Verb's keyword.
      # 
      def self.keyword
        return 'quit'
      end
      
      # 
      # Get the Verb's keyword shortcut.
      # 
      def self.keyword_shortcut
        return 'q'
      end

    end
  end
end
