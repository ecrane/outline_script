# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# The Gloo Script Engine.
# The Engine aggregates all the elements needed to run gloo.
# The Engine runs the main event loop and delegates processing
# to the relevant element.
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
      attr_accessor :exec_env, :help, :converter

      #
      # Set up the engine with basic elements.
      #
      def initialize( params = [] )
        $engine = self
        @args = Args.new( params )
        $settings = Settings.new( ENV[ 'GLOO_ENV' ] )
        $log = Log.new( @args.quiet? )
        $prompt = TTY::Prompt.new
        $log.debug 'engine intialized...'
      end

      #
      # Start the engine.
      # Load object and verb definitions and setup engine elements.
      #
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

        @exec_env = Gloo::Exec::ExecEnv.new
        @help = Gloo::App::Help.new
        @converter = Gloo::Convert::Converter.new

        $log.debug 'the engine has started'
        run_mode
      end

      # ---------------------------------------------------------------------
      #    Run
      # ---------------------------------------------------------------------

      #
      # Run gloo in the selected mode.
      #
      def run_mode
        $log.debug "running gloo in #{@mode} mode"

        if @mode == Mode::VERSION
          run_version
        elsif @mode == Mode::HELP
          show_help_and_quit
        elsif @mode == Mode::SCRIPT
          run_files
        else
          run
        end
      end

      #
      # Run files specified on the CLI.
      # Then quit.
      #
      def run_files
        @args.files.each { |f| @persist_man.load( f ) }
        quit
      end

      #
      # Run in interactive mode.
      #
      def run
        # Open default file(s)
        self.open_start_file

        # TODO: open any files specifed in args

        unless @mode == Mode::SCRIPT || @args.quiet?
          @cursor = TTY::Cursor
          self.loop
        end

        quit
      end

      #
      # Get the setting for the start_with file and open it.
      #
      def open_start_file
        name = $settings.start_with
        @persist_man.load( name ) if name
      end

      #
      # Prompt for the next command.
      #
      def prompt_cmd
        @last_cmd = $prompt.ask( default_prompt )
      end

      #
      # Get the default prompt text.
      #
      def default_prompt
        dt = DateTime.now
        d = dt.strftime( '%Y.%m.%d' )
        t = dt.strftime( '%I:%M:%S' )
        return "#{'gloo'.blue} #{d.yellow} #{t.white} >"
      end

      #
      # Is the last command entered blank?
      #
      def last_cmd_blank?
        return true if @last_cmd.nil?
        return true if @last_cmd.strip.empty?

        return false
      end

      #
      # Prompt, Get input, process.
      #
      def loop
        while @running
          prompt_cmd
          process_cmd
        end
      end

      #
      # Process the command.
      #
      def process_cmd
        if last_cmd_blank?
          clear_screen
          return
        end

        @parser.run @last_cmd
      end

      #
      # Request the engine to stop running.
      #
      def stop_running
        @running = false
      end

      #
      # Do any clean up and quit.
      #
      def quit
        $log.debug 'quitting...'
      end

      # ---------------------------------------------------------------------
      #    Helpers
      # ---------------------------------------------------------------------

      #
      # Show the version information and then quit.
      #
      def run_version
        puts Info.display_title unless @args.quiet?
        quit
      end

      #
      # Show the help information and then quit.
      #
      def show_help_and_quit
        @help.show_app_help
        quit
      end

      #
      # Clear the screen.
      #
      def clear_screen
        @cursor ||= TTY::Cursor
        print @cursor.clear_screen
        print @cursor.move_to( 0, 0 )
      end

      # ---------------------------------------------------------------------
      #    Error Handling
      # ---------------------------------------------------------------------

      #
      # Did the last command result in an error?
      #
      def error?
        return !@heap.error.value.nil?
      end

      #
      # Report an error.
      # Write it to the log and set the heap error value.
      #
      def err( msg )
        $log.error msg
        self.heap.error.set_to msg
      end

    end
  end
end
