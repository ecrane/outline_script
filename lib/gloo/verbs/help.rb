# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Show the help information.
#

module Gloo
  module Verbs
    class Help < Gloo::Core::Verb

      KEYWORD = 'help'.freeze
      KEYWORD_SHORT = '?'.freeze

      DISPATCH = {
        verb: 'show_verbs',
        verbs: 'show_verbs',
        v: 'show_verbs',
        obj: 'show_objs',
        object: 'show_objs',
        objects: 'show_objs',
        o: 'show_objs'
      }.freeze

      #
      # Run the verb.
      #
      def run
        opts = @tokens.second if @tokens
        opts = opts.strip.downcase if opts

        if opts
          self.dispatch opts
        else
          show_default
        end
      end

      #
      # Dispatch the help to the right place.
      #
      def dispatch( opts )
        cmd = DISPATCH[ opts.to_sym ]
        if cmd
          send cmd
        else
          entity_help opts
        end
      rescue
        report_help_error opts
      end

      #
      # Dispatch the help command to a verb or object
      # if we can find one matching the request.
      #
      def entity_help( opts )
        return if try_verb_help opts
        return if try_object_help opts

        report_help_error opts
      end

      #
      # See if there is a verb we can show help
      # information about.
      #
      def try_verb_help( opts )
        if $engine.dictionary.verb?( opts )
          # TODO:  Show help for the verb specified.
          return true
        end

        return false
      end

      #
      # See if there is a verb we can show help
      # information about.
      #
      def try_object_help( opts )
        if $engine.dictionary.obj?( opts )
          # TODO:  Show help for the object specified.
          return true
        end

        return false
      end

      #
      # Lookup the opts in the dispatch table.
      #
      def lookup_opts( opts )
        return DISPATCH[ opts.to_sym ]
      end

      #
      # Report an error with the inline help.
      #
      def report_help_error( opts )
        msg = "Help command '#{opts}' could not be found"
        $log.warn msg
        $engine.heap.error.set_to msg
      end

      #
      # If no parameter is given, show the default help page.
      #
      def show_default
        $engine.run_help( true )
      end

      #
      # List the verbs
      #
      def show_verbs
        out = self.get_verb_list
        $engine.heap.it.set_to out
        puts out unless $engine.args.quiet?
      end

      #
      # Get the text for the list of verbs.
      #
      def get_verb_list
        out = "Verbs:\n"
        $engine.dictionary.get_verbs.each do |v|
          out << " \t #{v.keyword_shortcut} \t #{v.keyword}\n"
        end
        return out
      end

      #
      # List the object types
      #
      def show_objs
        out = self.get_obj_list
        $engine.heap.it.set_to out
        puts out unless $engine.args.quiet?
      end

      #
      # Get the text for the list of verbs.
      #
      def get_obj_list
        out = "Object Types:\n"
        $engine.dictionary.get_obj_types.each do |v|
          out << " \t #{v.short_typename} \t #{v.typename}\n"
        end
        return out
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
