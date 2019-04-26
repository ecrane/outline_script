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
      def save name=""
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
        @maps.each do |o|
          o.save
        end
      end
      
      # 
      # Save one object to the file.
      # 
      def save_one name
        ref = Gloo::Core::Pn.new name
        obj = ref.resolve
        pn = get_full_path_name name
        fs = Gloo::Persist::FileStorage.new( pn, obj )
        fs.save
      end
      
      # 
      # Load the object from the file.
      # 
      def load name
        pn = get_full_path_name name
        return unless pn
        fs = Gloo::Persist::FileStorage.new( pn )
        fs.load
        @maps << fs
        $engine.event_manager.on_load fs.obj
        # show_maps
      end
      
      # 
      # Get the full path and name of the file.
      # 
      def get_full_path_name name
        return nil if name.strip.empty?
        path = $settings.project_path
        full_name = "#{name}#{file_ext}"
        return File.join( path, full_name )
      end
      
      # Get the default file extention.
      def file_ext
        return ".gloo"
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
