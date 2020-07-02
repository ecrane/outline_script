# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# The persistance manager.
# Keeps a collection of object-file mappings, and then
# uses mappings to know how/where to save updated objects.
#

module Gloo
  module Persist
    class PersistMan

      attr_reader :maps

      # Contructor for the persistence manager.
      def initialize
        @maps = []
      end

      #
      # Save one object to the file.
      #
      def save( name = '' )
        if name.nil? || name.strip.empty?
          save_all
        else
          save_one name
        end
      end

      #
      # Save one object to the file.
      #
      def save_all
        @maps.each( &:save )
      end

      #
      # Save one object to the file.
      #
      def save_one( name )
        ref = Gloo::Core::Pn.new name
        obj = ref.resolve
        pn = get_full_path_name name
        fs = Gloo::Persist::FileStorage.new( pn, obj )
        fs.save
      end

      #
      # Load the object from the file.
      #
      def load( name )
        pns = get_full_path_names name
        return unless pns

        pns.each do |pn|
          $log.debug "Load file(s) at: #{pn}"
          fs = Gloo::Persist::FileStorage.new( pn )
          fs.load
          @maps << fs
          $engine.event_manager.on_load fs.obj
        end
      end

      #
      # Get the full path and name of the file.
      #
      def get_full_path_names( name )
        return nil if name.strip.empty?

        if name.strip[ -1 ] == '*'
          pns = []
          dir = File.join( $settings.project_path, name[ 0..-2 ] )
          Dir.glob( "#{dir}*.gloo" ).each do |f|
            pns << f
          end
          return pns
        else
          ext_path = File.expand_path( name )
          return [ ext_path ] if self.gloo_file?( ext_path )

          full_name = "#{name}#{file_ext}"
          return [ File.join( $settings.project_path, full_name ) ]
        end
      end

      #
      # Check to see if a given path name refers to a gloo object file.
      #
      def gloo_file?( name )
        return false unless name
        return false unless File.exist?( name )
        return false unless File.file?( name )
        return false unless name.end_with?( self.file_ext )

        return true
      end

      # Get the default file extention.
      def file_ext
        return '.gloo'
      end

      # Print out all object - persistance mappings.
      # This is a debugging tool.
      def show_maps
        @maps.each do |o|
          puts " \t #{o.pn} \t #{o.obj.name}"
        end
      end

    end
  end
end
