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
      # Parameter hash keys:
      #  :name - the name of the object
      #  :type - the name of the type
      #  :value - the initial object value
      #  :parent - the parent object
      #  :squash_duplicates - if the object exists, use it rather
      #                       than creating a new one?  Default = true
      def create( params )
        objtype = find_type params[ :type ]
        return nil unless objtype

        pn = Gloo::Core::Pn.new params[ :name ]
        parent = params[ :parent ]
        if parent.nil?
          parent = pn.get_parent
          obj_name = pn.name
        else
          obj_name = params[ :name ]
        end

        if pn.exists? && params[ :squash_duplicates ]
          o = pn.resolve
          o.set_value params[ :value ]
          return o
        else
          o = objtype.new
          o.name = obj_name
          o.set_value params[ :value ]

          if parent
            parent.add_child( o )
            return o
          else
            $log.error "Could not create object.  Bad path: #{name}"
            return nil
          end
        end
      end

      #
      # Find the object type by name.
      # Return nil if the object type cannot be found or
      # cannot be created.
      #
      def find_type( type_name )
        type_name = 'untyped' if type_name.nil? || type_name.strip.empty?
        t = $engine.dictionary.find_obj( type_name )

        if t.nil?
          $log.warn "Could not find type, '#{type_name}'"
          return nil
        end

        unless t.can_create?
          $log.error "'#{type_name}' cannot be created."
          return nil
        end

        return t
      end

    end
  end
end
