# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An abstract base verb, which is also an obj.
#

module OutlineScript
  module Core
    class Verb < Obj
      
      # Set up the verb.
      def initialize()
      end
      
      # Register verbs when they are loaded.
      def self.inherited( subclass )
        Dictionary.instance.register_verb( subclass )
      end
      
      # 
      # Run the verb.
      # 
      # We'll mark the application as not running and let the
      # engine stop gracefully next time through the loop.
      # 
      def run
        raise 'this method should be overriden'
      end
      
      # 
      # Get the Verb's keyword.
      # 
      # The keyword will be in lower case only.
      # It is used by the parser.
      # 
      def self.keyword
        raise 'this method should be overriden'
      end

    end
  end
end
