# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# The Outline Script Engine.
#

require 'tty-prompt'
require 'tty-cursor'
require 'colorize'

module OutlineScript
  module App
    class Engine

      attr_reader :args, :mode
      
      # Set up the engine with basic elements.
      def initialize( params = [] )
        $engine = self
        @args = Args.new( params )
        $settings = Settings.new
        $log = Log.new
        $log.debug "engine intialized..."
      end
      
      # Start the engine.
      def start
        $log.debug "starting the engine..."
        $log.debug Info.display_title
        @mode = @args.detect_mode
        @running = true
        
        run_mode
      end
      
      # Run the selected mode.
      def run_mode
        if @mode == Mode::VERSION
          run_version
        elsif @mode == Mode::HELP
          run_help
        else
          run
        end
      end

      # Run
      def run
        # TODO: open any files specifed in args
        # TODO: run any scripts in open files
        
        unless @mode == Mode::SCRIPT
          $prompt = TTY::Prompt.new
          @cursor = TTY::Cursor
          self.loop 
        end

        quit
      end

      # Prompt for the next command.
      def prompt_cmd
        dt = DateTime.now
        d = dt.strftime( '%Y.%m.%d' )
        t = dt.strftime( '%I:%M:%S' )

        @last_cmd = $prompt.ask( "#{d.yellow} #{t.white} >" )
      end

      # Prompt, Get input, process.
      def loop
        while @running
          prompt_cmd
          process_cmd
        end
      end
      
      # Process the command.
      def process_cmd
        @running = false if @last_cmd == 'quit'
      end

      
      # Do any clean up and quit.
      def quit
        $log.debug "quitting..."
      end
      
      # Show the version information and then quit.
      def run_version
        puts Info.display_title unless @args.quiet?
        quit
      end

      # Show the help information and then quit.
      def run_help
        unless @args.quiet?
          puts Info.display_title
          puts "\nNAME\n\toutline_script\n\n"
          puts "\nDESCRIPTION\n\tOutline scripting language.  A scripting language built on ruby.\n"
          puts "\tMore information coming soon.\n\n"
          puts "\nSYNOPSIS\n\toscript [global option] [file]\n\n"
          puts "\nGLOBAL OPTIONS\n"
          puts "\t--cli \t\t - Run in CLI mode\n"
          puts "\t--version \t - Show application version\n"
          puts "\t--help \t\t - Show this help page\n"
          puts "\n"
        end
        quit
      end
      
    end
  end
end
