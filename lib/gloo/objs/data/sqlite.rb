# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# A Sqlite3 database connection.
#
# https://www.rubydoc.info/gems/sqlite3/1.3.11
#
require 'sqlite3'

module Gloo
  module Objs
    class Sqlite < Gloo::Core::Obj

      KEYWORD = 'sqlite'.freeze
      KEYWORD_SHORT = 'sqlite'.freeze

      DB = 'database'.freeze
      DEFAULT_DB = 'test.db'.freeze

      NOT_IMPLEMENTED_ERR = 'Not implemented yet!'.freeze

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
        fac.create_string DB, DEFAULT_DB, self
      end

      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      #
      # Get a list of message names that this object receives.
      #
      def self.messages
        return super + [ 'verify' ]
      end

      #
      # Verify access to the Sqlite database specified.
      #
      def msg_verify
        $engine.err NOT_IMPLEMENTED_ERR
      end

      # ---------------------------------------------------------------------
      #    Private functions
      # ---------------------------------------------------------------------

      private

      #
      # Get the Database file from the child object.
      # Returns nil if there is none.
      #
      def db_value
        o = find_child DB
        return nil unless o

        return o.value
      end

    end
  end
end
