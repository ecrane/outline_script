# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An object factory.
#

module Gloo
  module Core
    class Factory < Baseo
            
      # Set up the object factory.
      def initialize()
        $log.debug "object factory intialized..."
      end
      
      # Create object with given name, type and value.
      # One of either name or type is required.
      # All values are optional when considered on their own.
      def create name=nil, type=nil, value=nil
        type = type ? type : "untyped"
        objtype = $engine.dictionary.find_obj( type )
        
        if objtype
          o = objtype.new
          
          pn = Gloo::Core::Pn.new name
          o.name = pn.name
          o.set_value value
          
          parent = pn.get_parent
          if parent
            parent.add_child( o )
            return o          
          else
            $log.error "Could not create object.  Bad path: #{name}"
            return nil
          end
        else
          $log.warn "Could not find type, '#{type}'"
          return nil
        end        
      end
            
    end
  end
end
