# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Helper class takes an object and writes it to a file.
#

module Gloo
  module Persist
    class FileStorage
      
      # Set up a file storage for an object.
      def initialize pn, obj=nil
        @obj = obj
        @pn = pn
        @tabs = 0
      end
      
      # 
      # Save the object to the file.
      # 
      def save
        fs = FileSaver.new @pn, @obj
        fs.save
      end
      
      # 
      # Load the object from the file.
      # 
      def load
        fl = FileLoader.new @pn
        fl.load
      end
    
    end
  end
end
