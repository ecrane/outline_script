# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Utility used to find objects.
#

module Gloo
  module Core
    class ObjFinder
                  
      # 
      # Find all objects in the given container that have
      # the given name.
      # If the container isn't provided, root will be used.
      # 
      def self.by_name name, container=nil
        if container.nil?
          container = $engine.heap.root
        end
        arr = []
        
        container.children.each do |o|
          arr << o if o.name == name
          if o.child_count > 0
            arr += by_name( name, o )
          end
        end
        
        return arr
      end
      
      
    end
  end
end
