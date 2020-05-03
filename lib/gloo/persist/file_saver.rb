# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Helper class used to save an object to a file..
#

module Gloo
  module Persist
    class FileSaver

      # Set up a file storage for an object.
      def initialize( pn, obj )
        @pn = pn
        @obj = obj
      end

      #
      # Save the object to the file.
      #
      def save
        data = get_obj( @obj )
        File.write( @pn, data )
      end

      # Get string of tabs for indentation.
      def tabs( indent = 0 )
        return "\t" * indent
      end

      # Convert an object to textual representation.
      # This is a recursive function.
      def get_obj( o, indent = 0 )
        t = tabs( indent )
        str = "#{t}#{o.name} [#{o.type_display}] : #{o.value_display}\n"
        o.children.each do |child|
          str << get_obj( child, indent + 1 )
        end
        return str
      end

    end
  end
end
