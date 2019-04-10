# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An object path name.
# Path and name elements are separated by periods.
#

module OutlineScript
  module Core
    class Pn < Baseo

      attr_reader :src, :elements
      
      # Set up the object given a source string,
      # ie: the full path and name.
      def initialize( src )
        @src = src
        @elements = src.split( '.' )
      end
      
      # Get the name element.
      def name
        return "" unless self.has_name?
        return @elements.last
      end

      # Does the value include path elements?
      def has_name?
        return @elements.count > 0
      end

      # Does the value include a name?
      def has_path?
        return @elements.count > 1
      end
      
      # Get the parent that contains the object referenced.
      def get_parent
        o = $engine.heap.root
        
        if self.has_path?
          @elements[0..-2].each do |e|
            o = o.find_child( e )
          end
        end
        
        return o
      end
      
      # Does the object at the path exist?
      def exists?
      end
            
    end
  end
end
