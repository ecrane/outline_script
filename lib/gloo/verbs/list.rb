# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# List out an object and it's children.
#

module Gloo
  module Verbs
    class List < Gloo::Core::Verb
      
      KEYWORD = 'list'
      KEYWORD_SHORT = '.'

      # 
      # Run the verb.
      # 
      def run
        levels = determine_levels
        target = self.determine_target
        obj = target.resolve
        if obj
          self.show_target( obj, levels )
        else
          $log.warn "Object #{target} does not exist"
        end
      end

      # Determine how many levels to show.
      def determine_levels
        # Check settings for the default value.
        levels = $settings.list_indent
        return levels if levels
        
        # Last chance: use the default
        return 1
      end
      
      # Determine the target object for the show command.
      def determine_target
        if @tokens.token_count == 1
          return $engine.heap.context
        else
          return Gloo::Core::Pn.new( @tokens.second )
        end
      end

      # Show the target object.
      def show_target( obj, levels, indent="" )
        show_obj( obj, indent )
        
        return if levels == 0
        obj.children.each do |o| 
          show_target( o, levels - 1, "#{indent}  " )
        end
      end
      
      # Show object in standard format.
      def show_obj obj, indent="  "
        if obj.has_multiline_value? && obj.value_is_array?
          $log.show "#{indent}#{obj.name} [#{obj.type_display}] :"
          obj.value.each do |line|
            $log.show "#{indent}  #{line}"
          end
        else
          $log.show "#{indent}#{obj.name} [#{obj.type_display}] : #{obj.value}"
        end
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
