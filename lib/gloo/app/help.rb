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

      # Get text to display when the application is run
      # in HELP mode.
      def self.get_help_text
        load_help_files

        return <<~TEXT
          NAME
          \tgloo

          DESCRIPTION
          \tGloo scripting language.  A scripting language built on ruby.
          \tMore information coming soon.

          SYNOPSIS
          \tgloo [global option] [file]

          GLOBAL OPTIONS
          \t--cli \t\t - Run in CLI mode
          \t--version \t - Show application version
          \t--help \t\t - Show this help page

        TEXT
      end

      def self.load_help_files
        pn = File.dirname( File.absolute_path( __FILE__ ) )
        pn = File.dirname( pn )
        root = File.join( pn, 'help', '**/*.md' )
        Dir.glob( root ).each do |md_file|
          $log.debug md_file
          data = File.read md_file

          puts TTY::Markdown.parse data
          # md = TTY::Markdown.parse data
          # pager = TTY::Pager.new
          # pager.page( md )
        end
      end

    end
  end
end
