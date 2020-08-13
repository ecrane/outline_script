# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An object that contains a collection of other objects.
#
require 'tty-table'
require 'pastel'

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
        return super + %w[count delete_children show_key_value_table]
      end

      #
      # Count the number of children in the container.
      #
      def msg_count
        i = child_count
        $engine.heap.it.set_to i
        return i
      end

      #
      # Delete all children in the container.
      #
      def msg_delete_children
        self.delete_children
      end

      #
      # Show the given table data.
      #
      def msg_show_key_value_table
        data = self.children.map { |o| [ o.name, o.value ] }
        pastel = ::Pastel.new
        table = TTY::Table.new rows: data
        pad = [ 0, 1, 0, 1 ]
        rendered = table.render( :ascii, indent: 2, padding: pad ) do |r|
          r.border.style = :blue
          r.filter = proc do |val, _row_index, col_index|
            col_index.zero? ? pastel.blue( val ) : pastel.white( val )
          end
        end
        puts "\n  #{rendered}\n\n"
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
            delete_children - Delete all children objects from the container.
            show_key_value_tbl - Show a table with key (name) and values
              for all children in the container.
        TEXT
      end

    end
  end
end
