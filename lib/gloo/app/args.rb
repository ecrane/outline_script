# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Arguments (parameters) used to specify functionality.
# These might have come from the CLI or as parameters
# in the constructor.
#
require 'active_support'
require 'colorize'

module Gloo
  module App
    class Args

      attr_reader :switches, :files

      def initialize( params = [] )
        @switches = []
        @files = []

        params.each { |o| process_one_arg( o ) }
        ARGV.each { |o| process_one_arg( o ) }
      end

      # Was the --quiet arg passed?
      def quiet?
        return @switches.include?( 'quiet' )
      end

      #
      # Detect the mode to be run in.
      # Start by seeing if a mode is specified.
      # Then look for the presence of files.
      # Then finally use the default: embedded mode.
      #
      def detect_mode
        mode = if ENV[ 'GLOO_ENV' ] == 'test'
                 Mode::TEST
               elsif @switches.include?( 'version' )
                 Mode::VERSION
               elsif @switches.include?( 'help' )
                 Mode::HELP
               elsif @switches.include?( 'cli' )
                 Mode::CLI
               elsif @switches.include?( 'embed' )
                 Mode::EMBED
               elsif @files.count.positive?
                 Mode::SCRIPT
               else
                 Mode.default_mode
               end
        $log.debug "running in #{mode} mode"

        return mode
      end

      private

      # Process one argument or parameter.
      def process_one_arg( arg )
        if arg.start_with? '--'
          switches << arg[ 2..-1 ]
        else
          files << arg
        end
      end

    end
  end
end
