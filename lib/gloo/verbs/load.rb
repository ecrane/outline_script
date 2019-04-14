# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Save an object to a file or other persistance mechcanism.
#

module Gloo
  module Verbs
    class Load < Gloo::Core::Verb
      
      KEYWORD = 'load'
      KEYWORD_SHORT = '<'

      # 
      # Run the verb.
      # 
      def run
        name = @tokens.second
        pn = "/Users/ecrane/gloo/projects/helloworld.gloo"
        fs = Gloo::Persist::FileStorage.new( pn )
        fs.load
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
