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
      def run
        if @tokens.token_count == 1
          ref = $engine.heap.context
        else
          ref = OutlineScript::Core::ObjRef.new @tokens.second
        end
        
        # Make sure object exists
        if ref.obj_exists?
          # show object(s) at path
          cnt = $engine.heap.root.count
          $log.show "#{ref} exists (#{cnt})"
          
          $engine.heap.root.each { |o| show_obj( o ) }
        else
          $log.warn "Object #{ref} does not exist"
        end
      end
      
      # Show object in standard format.
      def show_obj obj, indent="  "
        $log.show "#{indent}#{obj.name} as #{obj.type_display} : #{obj.value}"
      end
      
      # 
      # Get the Verb's keyword.
      # 
      def self.keyword
        return 'show'
      end

      # 
      # Get the Verb's keyword shortcut.
      # 
      def self.keyword_shortcut
        return '.'
      end

    end
  end
end
