# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Application and user settings.
#

require 'yaml'
require 'tty-screen'
require 'colorize'

module OutlineScript
  module App
    class Settings

      attr_reader :user_root, :log_path, :config_path, :project_path


      # Load setting from the yml file.
      def initialize
        init_path_settings
        init_user_settings
      end

      # Get the app's required directories.
      def init_path_settings
        @user_root = File.join( Dir.home, "outline_script" )
        Dir.mkdir( @user_root ) unless File.exists?( @user_root )

        @log_path = File.join( @user_root, "logs" )
        Dir.mkdir( @log_path ) unless File.exists?( @log_path )

        @config_path = File.join( @user_root, "config" )
        Dir.mkdir( @config_path ) unless File.exists?( @config_path )
      end

      def init_user_settings
        settings = get_settings
        @project_path = settings[ 'outline_script' ][ 'project_path' ]
      end
      
      # Get the app's required directories.
      def get_settings
        f = File.join( @config_path, "outline_script.yml" )
        create_settings( f ) unless File.exists?( f )
        return YAML::load_file f
      end

      # Create settings file.
      def create_settings f
        IO.write( f, get_default_settings )
      end

      # Get the value for default settings.
      def get_default_settings
        home_dir = Dir.home
        projects = File.join( @user_root, "projects" )
        str = <<TEXT
outline_script:
  project_path: #{projects}
TEXT
        return str
      end

      # Show the current application settings.
      def show
        puts "\nApplication Settings:".blue
        puts "  User Root Path is here:  ".yellow + @user_root.white
        puts "  Projects directory:  ".yellow + @projects.white
        puts ""
        puts "  Screen Lines:  ".yellow + "#{Settings.lines}".white
        puts "  Page Size:  ".yellow + "#{Settings.page_size}".white
        puts ""
      end

      # Get the number of lines on screen.
      def self.lines
        TTY::Screen.rows
      end

      def self.cols
        TTY::Screen.cols
      end

      # Get the default page size.
      def self.page_size
        Settings.lines - 3
      end

      # How many lines should we use for a preview?
      def self.preview_lines
        return 7
      end

    end
  end
end