# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Helper class used to load a file and create objects in the heap.
#

module Gloo
  module Persist
    class FileLoader
      
      # Set up a file storage for an object.
      def initialize pn
        @pn = pn
        @tabs = 0
      end
            
      # 
      # Load the objects from the file.
      # 
      def load
        @tabs = 0
        @parent_stack = []
        @parent = $engine.heap.root
        @parent_stack.push @parent
        f = File.open( @pn, "r" ) 
        f.each_line do |line|
          process_line line
        end
      end
      
      # Process one line and add objects.
      def process_line line
        tabs = tab_count( line )
        if tabs > @tabs  # indent
          # TODO:  What if indent is more than one more level?
          @tabs = tabs
          @parent = @last
          @parent_stack.push @parent
        elsif tabs < @tabs  # outdent
          while tabs < @tabs
            @tabs -= 1
            @parent = @parent_stack.pop
          end
        end
        
        name, type, value = split_line( line )
        @last = $engine.factory.create( name, type, value, @parent )
      end
      
      # Get the number of leading tabs.
      def tab_count line
        i = 0
        while line[i] == "\t"
          i += 1
        end
        return i
      end
      
      # Split the line into 3 parts.
      def split_line line
        line = line[ @tabs..-1].strip
        i = line.index( ' ' )
        name = line[0..i-1]
        
        line = line[i+1..-1]
        i = line.index( ' ' )
        type = line[0..i-1]
        type = type[1..-1] if type[0] == '['
        type = type[0..-2] if type[-1] == ']'
        
        value = line[i+1..-1]
        value = value[1..-1] if value[0] == ':'
        value = value.strip
        return name, type, value
      end
      
    end
  end
end
