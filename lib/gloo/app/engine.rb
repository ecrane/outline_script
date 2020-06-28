# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# The Gloo Script Engine.
#

require 'tty-prompt'
require 'tty-cursor'
require 'colorize'

module Gloo
  module App
    class Engine

      attr_reader :args, :mode, :running
      attr_reader :dictionary, :parser, :heap, :factory
      attr_accessor :last_cmd, :persist_man, :event_manager

      # Set up the engine with basic elements.
      def initialize( params = [] )
        $engine = self
        @args = Args.new( params )
        $settings = Settings.new( ENV[ 'GLOO_ENV' ] )
        $log = Log.new( @args.quiet? )
        $prompt = TTY::Prompt.new
        $log.debug 'engine intialized...'
      end

      # Start the engine.
      def start
        $log.debug 'starting the engine...'
        $log.debug Info.display_title
        @mode = @args.detect_mode
        @running = true

        @dictionary = Gloo::Core::Dictionary.instance
        @dictionary.init
        @parser = Gloo::Core::Parser.new
        @heap = Gloo::Core::Heap.new
        @factory = Gloo::Core::Factory.new
        @persist_man = Gloo::Persist::PersistMan.new
        @event_manager = Gloo::Core::EventManager.new

        run_mode
      end

      # Run the selected mode.
      def run_mode
        if @mode == Mode::VERSION
          run_version
        elsif @mode == Mode::HELP
          run_help
        elsif @mode == Mode::SCRIPT
          run_files
        else
          run
        end
      end

      # Run files specified on the CLI.
      # Then quit.
      def run_files
        @args.files.each do |f|
          @persist_man.load( f )
        end

        quit
      end

      # Run
      def run
        # Open default files
        self.open_start_file

        # TODO: open any files specifed in args

        unless @mode == Mode::SCRIPT || @args.quiet?
          @cursor = TTY::Cursor
          self.loop
        end

        quit
      end

      # Get the setting for the start_with file and open it.
      def open_start_file
        name = $settings.start_with
        @persist_man.load( name ) if name
      end

      # Prompt for the next command.
      def prompt_cmd
        dt = DateTime.now
        d = dt.strftime( '%Y.%m.%d' )
        t = dt.strftime( '%I:%M:%S' )

        @last_cmd = $prompt.ask( "#{'gloo'.blue} #{d.yellow} #{t.white} >" )
      end

      # Is the last command entered blank?
      def last_cmd_blank?
        return true if @last_cmd.nil?
        return true if @last_cmd.strip.empty?
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
        if last_cmd_blank?
          clear_screen
          return
        end

        @immediate = @parser.parse_immediate @last_cmd
        Gloo::Core::Runner.go( @immediate ) if @immediate
      end

      # Request the engine to stop running.
      def stop_running
        @running = false
      end

      # Do any clean up and quit.
      def quit
        $log.debug 'quitting...'
      end

      # Show the version information and then quit.
      def run_version
        puts Info.display_title unless @args.quiet?
        quit
      end

      # Show the help information and then quit.
      def run_help( keep_running = false )
        out = "#{Info.display_title}\n"
        out << Help.get_help_text
        $engine.heap.it.set_to out
        puts out unless @args.quiet?
        quit unless keep_running
      end

      # Clear the screen.
      def clear_screen
        @cursor ||= TTY::Cursor
        print @cursor.clear_screen
        print @cursor.move_to( 0, 0 )
      end

      # Did the last command result in an error?
      def error?
        return !@heap.error.value.nil?
      end

    end
  end
end
