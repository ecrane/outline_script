# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Show a single object's value.
# When used in CLI mode it might also show an object tree.
#

module OutlineScript
  module Verbs
    class Show < OutlineScript::Core::Verb
      
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
        return 'show'
      end

    end
  end
end
