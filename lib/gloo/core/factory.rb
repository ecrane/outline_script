# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An object factory.
#

module Gloo
  module Core
    class Factory < Baseo

      # Set up the object factory.
      def initialize
        $log.debug 'object factory intialized...'
      end

      # Create object with given name, type and value.
      # One of either name or type is required.
      # All values are optional when considered on their own.
      # squash = squash duplicates?
      def create( name = nil, type = nil, value = nil, p = nil, squash = true )
        # TODO: Clean up -- maybe use a hash instead of the long list of
        # parameters to the function?
        parent = p
        objtype = find_type type
        pn = Gloo::Core::Pn.new name
        if parent.nil?
          parent = pn.get_parent
          obj_name = pn.name
        else
          obj_name = name
        end

        if objtype
          unless objtype.can_create?
            $log.error "'#{type}' cannot be created."
            return nil
          end
          if pn.exists? && squash
            o = pn.resolve
            o.set_value value
            return o
          else
            o = objtype.new
            o.name = obj_name
            o.set_value value

            if parent
              parent.add_child( o )
              return o
            else
              $log.error "Could not create object.  Bad path: #{name}"
              return nil
            end
          end
        else
          $log.warn "Could not find type, '#{type}'"
          return nil
        end
      end

      # Find the object type by name.
      def find_type( type_name )
        type_name = 'untyped' if type_name.nil? || type_name.strip.empty?

        return $engine.dictionary.find_obj( type_name )
      end

    end
  end
end
