# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# Utilities related to words (strings).
#

module Gloo
  module Utils
    class Stats

      # ---------------------------------------------------------------------
      #    Setup
      # ---------------------------------------------------------------------

      #
      # Create a stats utility class for the given directory.
      #
      def initialize( dir )
        @dir = dir
      end

      # ---------------------------------------------------------------------
      #    Public Functions
      # ---------------------------------------------------------------------

      #
      # Is the stats utility valid?
      # Does it have a valid root directory.
      #
      def valid?
        return false unless @dir
        return false unless File.directory? @dir

        return true
      end

      #
      # Show all stat data for the project.
      #
      def show_all
        generate
        puts "Showing All stats for #{@dir}".white
        puts "\n ** #{@dir_cnt} Total Folders ** "
        puts " ** #{@file_cnt} Total Files ** "

        busy_folders( 7 )
        file_types
      end

      #
      # Get a list of the busiest folders.
      # Count is how many results we want.
      #
      def busy_folders( count = 17 )
        generate
        puts "\nBusy Folders:".yellow

        @folders.sort! { |a, b| a[ :cnt ] <=> b[ :cnt ] }
        @folders.reverse!
        @folders[ 0..count ].each do |f|
          puts "  #{f[ :cnt ]} - #{f[ :name ]}"
        end
      end

      #
      # Show file types and how many of each there are.
      #
      def file_types
        generate
        puts "\nFiles by Type:".yellow

        @types = @types.sort_by( &:last )
        @types.reverse!
        @types.each do |o|
          puts "  #{o[ 1 ]} - #{o[ 0 ]}" unless o[ 0 ].empty?
        end
      end

      # ---------------------------------------------------------------------
      #    Private Functions
      # ---------------------------------------------------------------------

      #
      # Generate stat data unless we've already done so.
      #
      def generate
        return if @folders

        $log.debug 'Generating...'
        @folders = []
        @types = {}
        @file_cnt = 0
        @dir_cnt = 0
        generate_for Pathname.new( @dir )
      end

      #
      # Generate data for the given path.
      # NOTE: this is a recursive function.
      # It traverses all sub-direcctories.
      #
      def generate_for( path )
        return if File.basename( path ) == '.git'

        cnt = 0
        path.children.each do |f|
          if f.directory?
            @dir_cnt += 1
            generate_for( f )
          else
            @file_cnt += 1
            cnt += 1
            # puts File.dirname( f )
            if @types[ File.extname( f ) ]
              @types[ File.extname( f ) ] += 1
            else
              @types[ File.extname( f ) ] = 1
            end
          end
        end
        @folders << { name: path, cnt: cnt }
      end

    end
  end
end
