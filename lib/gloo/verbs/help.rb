# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Show the help information.
#

module Gloo
  module Verbs
    class Help < Gloo::Core::Verb
      
      KEYWORD = 'help'
      KEYWORD_SHORT = '?'

      # 
      # Run the verb.
      # 
      def run
        $engine.run_help( true )
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
