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
      # Get a list of the busiest folders.
      # Count is how many results we want.
      #
      def busy_folders( count=7 )
        puts 'Busy Folders:'
        @folders = []
        find_busy_folders Pathname.new( @dir )

        @folders.sort! { |a, b| a[ :cnt ] <=> b[ :cnt ] }
        @folders.reverse!
        @folders[0..count].each do |f|
          puts "#{f[:cnt]} - #{f[:name]}"
        end
      end

      # ---------------------------------------------------------------------
      #    Private Functions
      # ---------------------------------------------------------------------

      def find_busy_folders path
        return if File.basename( path ) == '.git'
        cnt = 0
        path.children.each do |f|
          if f.directory?
            find_busy_folders( f )
          elsif
            cnt += 1
            # puts File.dirname( f )
          end
        end
        @folders << { name: path, cnt: cnt }
      end

    end
  end
end
