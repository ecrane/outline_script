# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Save an object to a file or other persistance mechcanism.
#

module Gloo
  module Verbs
    class Save < Gloo::Core::Verb
      
      KEYWORD = 'save'
      KEYWORD_SHORT = 's'

      # 
      # Run the verb.
      # 
      def run
        name = @tokens.second
        pn = Gloo::Core::Pn.new name
        obj = pn.resolve
        pn = "/Users/ecrane/gloo/projects/helloworld.gloo"
        fs = Gloo::Persist::FileStorage.new( obj, pn )
        fs.save
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
