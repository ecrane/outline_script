# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# A SQL database query.
# Relies on a database connection object.
#

module Gloo
  module Objs
    class Query < Gloo::Core::Obj

      KEYWORD = 'query'.freeze
      KEYWORD_SHORT = 'sql'.freeze

      DB = 'database'.freeze
      SQL = 'sql'.freeze
      RESULT = 'result'.freeze
      PARAMS = 'params'.freeze

      DB_MISSING_ERR = 'The database connection is missing!'.freeze

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
      #    Children
      # ---------------------------------------------------------------------

      #
      # Does this object have children to add when an object
      # is created in interactive mode?
      # This does not apply during obj load, etc.
      #
      def add_children_on_create?
        return true
      end

      #
      # Add children to this object.
      # This is used by containers to add children needed
      # for default configurations.
      #
      def add_default_children
        fac = $engine.factory
        fac.create_alias DB, nil, self
        fac.create_string SQL, nil, self
        fac.create_can RESULT, self
      end

      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      #
      # Get a list of message names that this object receives.
      #
      def self.messages
        return super + [ 'run' ]
      end

      #
      # SSH to the host and execute the command, then update result.
      #
      def msg_run
        db = db_obj
        unless db
          $engine.err DB_MISSING_ERR
          return
        end

        result = db.query( sql_value, param_array )
        process_result result
      end

      # ---------------------------------------------------------------------
      #    Private functions
      # ---------------------------------------------------------------------

      private

      #
      # Get the database connection.
      #
      def db_obj
        o = find_child DB
        return Gloo::Objs::Alias.resolve_alias( o )
      end

      #
      # Get the SQL from the child object.
      # Returns nil if there is none.
      #
      def sql_value
        o = find_child SQL
        return nil unless o

        return o.value
      end

      #
      # Do something with the result of the SQL Query call.
      # If there's a result container, we'll create objects in it.
      # If not, we'll just show the output in the console.
      #
      def process_result( data )
        r = find_child RESULT
        if r
          update_result_contaier data
        else
          show_result data
        end
      end

      #
      # Get the arrya of parameters.
      # If there is no PARAM container of if it is empty,
      # we'll return a nil value.
      #
      def param_array
        o = find_child PARAMS
        return nil unless o

        return nil if o.child_count.zero?

        params = []
        o.children.each do |p|
          params << p.value
        end

        return params
      end

      #
      # Show the result of the query in the console.
      #
      def show_result( data )
        return if data.nil?

        data.each_with_index do |row, i|
          # Show header for the first row
          puts row.map { |k, _| k }.join( " \t " ).white if i.zero?

          # Show the row data
          puts row.map { |_, v| v }.join( " \t " )
        end
      end

      #
      # Update the result container with the data from the query.
      #
      def update_result_contaier( data )
        r = find_child RESULT
        r = Gloo::Objs::Alias.resolve_alias( r )
        data.each_with_index do |row, i|
          can = r.find_add_child( i.to_s, 'can' )
          row.each do |k, v|
            o = can.find_add_child( k, 'untyped' )
            o.set_value v
          end
        end
      end

    end
  end
end
