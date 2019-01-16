# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Quick the running outline_script engine.
#

module OutlineScript
  module Verbs
    class Help < OutlineScript::Core::Verb
      
      # 
      # Run the verb.
      # 
      # We'll mark the application as not running and let the
      # engine stop gracefully next time through the loop.
      # 
      def run
        $engine.run_help( true )
      end
      
      # 
      # Get the Verb's keyword.
      # 
      def self.keyword
        return 'help'
      end

    end
  end
end
