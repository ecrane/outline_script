# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Create an object, optionally of a type.
#

module OutlineScript
  module Verbs
    class Create < OutlineScript::Core::Verb
      
      KEYWORD = 'create'
      KEYWORD_SHORT = '`'
      AS = 'as'
      VAL = ':'
      
      # 
      # Run the verb.
      # 
      def run
        name = @tokens.second
        type = @tokens.after_token( AS )
        value = @tokens.after_token( VAL )
        $engine.factory.create( name, type, value )
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
