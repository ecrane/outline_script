# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# A String.
#

module Gloo
  module Objs
    class Alias < Gloo::Core::Obj

      KEYWORD = 'alias'.freeze
      KEYWORD_SHORT = 'ln'.freeze
      ALIAS_REFERENCE = '*'.freeze

      #
      # The name of the object type.
      #
      def self.typename
        return KEYWORD
      end

      #
      # The short name of the object type.
      #
      def self.short_typename
        return KEYWORD_SHORT
      end

      #
      # Set the value with any necessary type conversions.
      #
      def set_value( new_value )
        self.value = new_value.to_s
      end

      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      #
      # Get a list of message names that this object receives.
      #
      def self.messages
        return super + %w[resolve]
      end

      #
      # Check to see if the referenced object exists.
      #
      def msg_resolve
        pn = Gloo::Core::Pn.new( self.value )
        s = pn.exists?
        $engine.heap.it.set_to s
        return s
      end

      # ---------------------------------------------------------------------
      #    Resolve
      # ---------------------------------------------------------------------

      #
      # Is the object an alias  If so, then resolve it.
      # The ref_name is the name used to refer to the object.
      # If it ends with the * then we won't resolve the alias since
      # we are trying to refer to the alias itself.
      #
      def self.resolve_alias( obj, ref_name = nil )
        return nil unless obj
        return obj unless obj.type_display == Gloo::Objs::Alias.typename
        return obj if ref_name&.end_with?( ALIAS_REFERENCE )

        ln = Gloo::Core::Pn.new( obj.value )
        return ln.resolve
      end

      # ---------------------------------------------------------------------
      #    Help
      # ---------------------------------------------------------------------

      #
      # Get help for this object type.
      #
      def self.help
        return <<~TEXT
          ALIAS OBJECT TYPE
            NAME: alias
            SHORTCUT: ln

          DESCRIPTION
            A pointer to another object.
            Normal path-name references will refere to the aliased object.
            To refer to the alias itself, add an * at the end of the path-name.
            This is neeed, for example, to set the value of the alias.
            The value of the alias is merely the path-name of the
            referenced object.

          CHILDREN
            None

          MESSAGES
            The alias will reflect the mesages of the object to which
            it points.
            The alias itself can receive the following message:
            resolve - Check to see if the object referenced exists.
                  Sets it to true or false.
        TEXT
      end

    end
  end
end
