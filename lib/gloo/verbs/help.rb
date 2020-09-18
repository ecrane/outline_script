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
      DEFAULT_HELP = 'default_help'.freeze
      HELP_NOT_FOUND_ERR = 'Help command could not be found:'.freeze

      DISPATCH = {
        settings: 'show_settings',
        keywords: 'show_keywords',
        verb: 'show_verbs',
        verbs: 'show_verbs',
        v: 'show_verbs',
        obj: 'show_objs',
        object: 'show_objs',
        objects: 'show_objs',
        o: 'show_objs',
        topics: 'show_topics'
      }.freeze

      #
      # Run the verb.
      #
      def run
        opts = @tokens.second if @tokens
        opts = opts.strip.downcase if opts

        if opts
          dispatch opts
        else
          $engine.help.page_topic DEFAULT_HELP
        end
      end

      #
      # Get the text for the list of verbs.
      #
      def get_verb_list
        out = "Verbs:\n"
        str = ''
        verbs = $engine.dictionary.get_verbs.sort_by( &:keyword )
        verbs.each_with_index do |v, i|
          cut = v.keyword_shortcut.ljust( 5, ' ' )
          str << " #{cut} #{v.keyword.ljust( 20, ' ' )}"
          if ( ( i + 1 ) % 3 ).zero?
            out << "#{str}\n"
            str = ''
          end
        end

        return out
      end

      #
      # Lookup the opts in the dispatch table.
      #
      def lookup_opts( opts )
        return DISPATCH[ opts.to_sym ]
      end

      #
      # Get the text for the list of verbs.
      #
      def get_obj_list
        out = "Object Types:\n"
        str = ''
        objs = $engine.dictionary.get_obj_types.sort_by( &:typename )
        objs.each_with_index do |o, i|
          name = o.typename
          if o.short_typename != o.typename
            name = "#{name} (#{o.short_typename})"
          end
          str << " #{name.ljust( 30, ' ' )}"
          if ( ( i + 1 ) % 4 ).zero?
            out << "#{str}\n"
            str = ''
          end
        end

        return out
      end

      #
      # Get the list of help topics.
      #
      def get_topics
        out = "Help Topics:\n"
        str = ''
        objs = $engine.help.topics.keys.sort
        objs.each_with_index do |o, i|
          str << " #{o.ljust( 30, ' ' )}"
          if ( ( i + 1 ) % 4 ).zero?
            out << "#{str}\n"
            str = ''
          end
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

      # ---------------------------------------------------------------------
      #    Private functions
      # ---------------------------------------------------------------------

      private

      #
      # Report an error with the inline help.
      #
      def report_help_error( opts )
        $engine.err "#{HELP_NOT_FOUND_ERR} '#{opts}'"
      end

      #
      # Dispatch the help to the right place.
      #
      def dispatch( opts )
        return if dispatch_help_page( opts )

        $log.debug 'looking for built in help topic'
        cmd = DISPATCH[ opts.to_sym ]
        if cmd
          $log.debug 'found help index'
          send cmd
        else
          $log.debug 'looking for entity help'
          entity_help opts
        end
      rescue
        report_help_error opts
      end

      #
      # Dispatch to a help page if we can find one.
      #
      def dispatch_help_page( opts )
        if $engine.help.topic? opts
          $log.debug 'found expanded help topic'
          $engine.help.page_topic opts
          return true
        end

        key = $engine.dictionary.lookup_keyword opts
        if $engine.help.topic? key
          $log.debug 'found expanded help topic'
          $engine.help.page_topic key
          return true
        end

        return false
      end

      #
      # Write output to it and show it unless we are in
      # silent mode.
      #
      def show_output( out )
        $engine.heap.it.set_to out
        puts out unless $engine.args.quiet?
      end

      #
      # List all help topics (articles)
      #
      def show_topics
        out = self.get_topics
        show_output out
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
          t = $engine.dictionary.find_verb( opts )
          out = t.send 'help'
          show_output out
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
          t = $engine.dictionary.find_obj( opts )
          out = t.send 'help'
          show_output out
          return true
        end

        return false
      end

      #
      # Show application settings.
      #
      def show_settings
        $settings.show
      end

      #
      # Show all keywords: verbs and objects.
      #
      def show_keywords
        $engine.dictionary.show_keywords
      end

      #
      # List the verbs
      #
      def show_verbs
        show_output get_verb_list
      end

      #
      # List the object types
      #
      def show_objs
        out = self.get_obj_list
        show_output out
      end

    end
  end
end
