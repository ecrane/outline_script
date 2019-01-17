# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Set the current context pointer.
#

module OutlineScript
  module Verbs
    class Context < OutlineScript::Core::Verb
      
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
        return 'context'
      end

    end
  end
end
