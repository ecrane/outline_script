# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# List out an object and it's children.
#

module OutlineScript
  module Verbs
    class List < OutlineScript::Core::Verb
      
      KEYWORD = 'list'
      KEYWORD_SHORT = '.'

      # 
      # Run the verb.
      # 
      def run
        target = self.determine_target
        obj = target.resolve
        if obj
          self.show_target( obj )
        else
          $log.warn "Object #{target} does not exist"
        end
      end
      
      # Determine the target object for the show command.
      def determine_target
        if @tokens.token_count == 1
          return $engine.heap.context
        else
          return OutlineScript::Core::Pn.new( @tokens.second )
        end
      end

      # Show the target object.
      def show_target( obj )
        show_obj( obj, "" )
        obj.children.each { |o| show_obj( o ) }
      end
      
      # Show object in standard format.
      def show_obj obj, indent="  "
        $log.show "#{indent}#{obj.name} [#{obj.type_display}] : #{obj.value}"
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
