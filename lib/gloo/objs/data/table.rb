# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# A data table.
# The table container headers and data.
#
require 'tty-table'
require 'pastel'

module Gloo
  module Objs
    class Table < Gloo::Core::Obj

      KEYWORD = 'table'.freeze
      KEYWORD_SHORT = 'tbl'.freeze
      HEADERS = 'headers'.freeze
      DATA = 'data'.freeze

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
      # Get the list of headers.
      # Returns nil if there is none.
      #
      def headers
        o = find_child HEADERS
        return [] unless o

        return o.children.map( &:value )
      end

      #
      # Get the list of column names.
      # Returns nil if there is none.
      #
      def columns
        o = find_child HEADERS
        return [] unless o

        return o.children.map( &:name )
      end

      #
      # Get the list of data elements.
      #
      def data
        o = find_child DATA
        return [] unless o

        o = Gloo::Objs::Alias.resolve_alias( o )
        cols = self.columns
        return o.children.map do |e|
          cols.map { |h| e.find_child( h ).value }
        end
      end

      # ---------------------------------------------------------------------
      #    Children
      # ---------------------------------------------------------------------

      # Does this object have children to add when an object
      # is created in interactive mode?
      # This does not apply during obj load, etc.
      def add_children_on_create?
        return true
      end

      # Add children to this object.
      # This is used by containers to add children needed
      # for default configurations.
      def add_default_children
        fac = $engine.factory
        fac.create_can HEADERS, self
        fac.create_can DATA, self
      end

      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      #
      # Get a list of message names that this object receives.
      #
      def self.messages
        return super + [ 'show' ]
      end

      #
      # Show the table in the CLI.
      #
      def msg_show
        Gloo::Objs::Table.show headers, data
      end

      # ---------------------------------------------------------------------
      #    Static table helper
      # ---------------------------------------------------------------------

      #
      # Show the given table data.
      #
      def self.show( headers, data )
        pastel = Pastel.new
        table = TTY::Table.new headers, data
        pad = [ 0, 1, 0, 1 ]
        rendered = table.render( :ascii, indent: 2, padding: pad ) do |r|
          r.border.style = :blue
          r.filter = proc do |val, row_index, _col_index|
            # col_index % 2 == 1 ? pastel.red.on_green(val) : val
            if row_index.zero?
              pastel.blue( val )
            else
              row_index.odd? ? pastel.white( val ) : pastel.yellow( val )
            end
          end
        end
        puts rendered
      end

      # ---------------------------------------------------------------------
      #    Help
      # ---------------------------------------------------------------------

      #
      # Get help for this object type.
      #
      def self.help
        return <<~TEXT
          TABLE OBJECT TYPE
            NAME: table
            SHORTCUT: tbl

          DESCRIPTION
            A data table.

          CHILDREN
            headers - container
              A list of headers.
              The name of the header object needs to be the same as the
              name of the object in the data container.
              The value of the header is what will be displayed.
            data - container
              The table's data.
              The data container will have one or more containers, each
              of which represents one row of data.

          MESSAGES
            show - Show the contents of the table in the CLI.
        TEXT
      end

    end
  end
end
