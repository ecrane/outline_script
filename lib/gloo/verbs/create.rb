# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Create an object, optionally of a type.
#

module Gloo
  module Verbs
    class Create < Gloo::Core::Verb
      
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
        
        if Gloo::Expr::LString.is_string?( value )
          value = Gloo::Expr::LString.strip_quotes( value )
        end
        obj = $engine.factory.create( name, type, value )
        
        if obj && obj.add_children_on_create?
          obj.add_default_children
        end
        
        $engine.heap.it.set_to value
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
