# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An object that contains a collection of other objects.
#

module Gloo
  module Objs
    class Container < Gloo::Core::Obj

      KEYWORD = 'container'.freeze
      KEYWORD_SHORT = 'can'.freeze

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

      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      #
      # Get a list of message names that this object receives.
      #
      def self.messages
        return super + [ 'count' ]
      end

      # Count the number of children in the container.
      def msg_count
        i = child_count
        $engine.heap.it.set_to i
        return i
      end

      # ---------------------------------------------------------------------
      #    Help
      # ---------------------------------------------------------------------

      #
      # Get help for this object type.
      #
      def self.help
        return <<~TEXT
          CONTAINER OBJECT TYPE
            NAME: container
            SHORTCUT: can

          DESCRIPTION
            A container of other objects.
            A container is similar to a folder in a file system.
            It can contain any number of objects including other containers.
            The container structure provides direct access to any object
            within it through the object.object.object path-name structure.

          CHILDREN
            None by default.  But any container can have any number of
            objects added to it.

          MESSAGES
            count - Count the number of children objects in the container.
                    The result is put in <it>.
        TEXT
      end

    end
  end
end
