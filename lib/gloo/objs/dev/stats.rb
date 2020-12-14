# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# Get statistics about a development project.
#

module Gloo
  module Objs
    class Stats < Gloo::Core::Obj

      KEYWORD = 'stats'.freeze
      KEYWORD_SHORT = 'stat'.freeze
      FOLDER = 'folder'.freeze

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
      # Get the path to the git repo (locally).
      #
      def path_value
        o = find_child FOLDER
        return o ? o.value : nil
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
        fac.create_file FOLDER, '', self
      end

      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      #
      # Get a list of message names that this object receives.
      #
      def self.messages
        all = %w[show_all]
        more = %w[show_busy_folders]
        return super + all + more
      end

      #
      # Review pending changes.
      #
      def msg_show_all
        $engine.err NOT_IMPLEMENTED_ERR
      end

      #
      # Review pending changes.
      #
      def msg_show_busy_folders
        # $engine.err NOT_IMPLEMENTED_ERR
        o = Gloo::Utils::Stats.new( path_value )
        o.busy_folders
      end

    end
  end
end
