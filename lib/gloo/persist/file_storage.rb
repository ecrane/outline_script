# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Helper class takes an object and writes it to a file.
#

module Gloo
  module Persist
    class FileStorage
      
      # Set up a file storage for an object.
      def initialize obj, pn
        @obj = obj
        @pn = pn
      end
      
      # 
      # Save the object to the file.
      # 
      def save
        File.write( @pn, get_obj( @obj ) )
      end
      
      # 
      # Load the object from the file.
      # 
      def load
      end
      
      # Constuct text from the obj.
      def get_file_content
        str = get_obj( @obj )
        return str
      end
      
      # Convert an object to textual representation.
      # This is a recursive function.
      def get_obj o, indent=0
        tabs = "\t" * indent
        str = "#{tabs}#{o.name} [#{o.type_display}] : #{o.value_display}\n"
        o.children.each do |child|
          str << get_obj( child, indent+1 )
        end
        return str
      end

    end
  end
end
