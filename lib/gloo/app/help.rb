# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Help system.
#

require 'tty-markdown'
require 'tty-pager'

module Gloo
  module App
    class Help

      APPLICATION = 'application'.freeze

      attr_accessor :topics

      #
      # Set up the help system.
      # We won't load help topics until we know we need them.
      #
      def initialize
        @topics = nil
      end

      #
      # Show application help.
      # This is the what is shown when help is run from the CLI.
      #
      def show_app_help
        puts Info.display_title unless $engine.args.quiet?
        self.show_topic APPLICATION
      end

      #
      # Check to see if there is a topic by the given name.
      #
      def topic?( name )
        lazy_load_index

        return @topics.key?( name )
      end

      #
      # Is the current topic Markdown?
      #
      def topic_is_md?( name )
        topic_file = @topics[ name ]
        return topic_file.end_with? '.md'
      end

      #
      # Show a help topic, optionally paginaged.
      # If the content of the help page fits on a single
      # screen, it won't paginate.
      #
      def page_topic( topic )
        return if $engine.args.quiet?

        data = self.get_topic_data( topic )
        page = data.lines.count > Settings.page_size
        if topic_is_md?( topic )
          show_markdown_data( data, page )
        else
          show_text_data( data, page )
        end
      end

      #
      # Show a help topic.
      #
      def show_topic( topic )
        return if $engine.args.quiet?

        data = self.get_topic_data( topic )
        if topic_is_md?( topic )
          show_markdown_data data
        else
          show_text_data data
        end
      end

      #
      # Show the markdown data.
      #
      def show_text_data( data, page = false )
        if page
          pager = TTY::Pager.new
          pager.page( data )
        else
          puts data.white
          puts
        end
      end

      #
      # Show the markdown data.
      #
      def show_markdown_data( data, page = false )
        md = TTY::Markdown.parse data

        if page
          pager = TTY::Pager.new
          pager.page( md )
        else
          puts md
          puts
        end
      end

      #
      # Get topic data.
      #
      def get_topic_data( topic )
        lazy_load_index

        topic_file = @topics[ topic ]
        File.read topic_file
      end

      #
      # Lazy load topic index.
      # We'll only load the index the first time a help topic
      # is requested.  After that we'll use the cached index.
      #
      def lazy_load_index
        return if @topics

        @topics = {}
        $log.debug 'loading help file index...'

        pn = File.dirname( File.absolute_path( __FILE__ ) )
        pn = File.dirname( pn )

        root = File.join( pn, 'help', '**/*.txt' )
        Dir.glob( root ).each do |txt_file|
          key = File.basename( txt_file, '.txt' )
          @topics[ key ] = txt_file
        end

        root = File.join( pn, 'help', '**/*.md' )
        Dir.glob( root ).each do |md_file|
          key = File.basename( md_file, '.md' )
          @topics[ key ] = md_file
        end

        $log.debug "Found #{@topics.count} help files"
      end

    end
  end
end
