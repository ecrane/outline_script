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
        opts = @tokens.second if @tokens
        opts = opts.strip.downcase if opts
				
        if opts && ( ( opts == 'verbs' ) || ( opts == 'v' ) )
          show_verbs
        elsif opts && ( ( opts == 'objects' ) || ( opts == 'o' ) )
          show_objs
        else
          $engine.run_help( true )
        end
      end
      
      # 
      # List the verbs
      # 
      def show_verbs
        return if $engine.args.quiet?

        puts "Verbs:"
        $engine.dictionary.get_verbs.each do |v|
          puts " \t #{v.keyword_shortcut} \t #{v.keyword}"
        end
      end

      # 
      # List the object types
      # 
      def show_objs
        return if $engine.args.quiet?

        puts "Object Types:"
        $engine.dictionary.get_obj_types.each do |v|
          puts " \t #{v.short_typename} \t #{v.typename}"
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
