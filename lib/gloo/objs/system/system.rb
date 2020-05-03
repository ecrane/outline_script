# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An object that can make a system call.
#

module Gloo
  module Objs
    class System < Gloo::Core::Obj

      KEYWORD = 'system'.freeze
      KEYWORD_SHORT = 'sys'.freeze
      CMD = 'command'.freeze
      RESULT = 'result'.freeze
      GET_OUTPUT = 'get_output'.freeze

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
      # Get the URI from the child object.
      # Returns nil if there is none.
      #
      def get_cmd
        cmd = find_child CMD
        return nil unless cmd
        return cmd.value
      end

      #
      # Set the result of the system call.
      #
      def set_result data
        r = find_child RESULT
        return nil unless r
        r.set_value data
      end

      #
      # Should the system call get output?
      # If so, the system call will run and get output,
      # otherwise it will just get the result of the call.
      #
      def has_output?
        o = find_child GET_OUTPUT
        return false unless o
        return o.value
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
        fac.create "command", "string", "date", self
        fac.create "get_output", "boolean", true, self
        fac.create "result", "string", nil, self
      end


      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      #
      # Get a list of message names that this object receives.
      #
      def self.messages
        return super + [ "run" ]
      end

      # Run the system command.
      def msg_run
        if has_output?
          run_with_output
        else
          run_with_result
        end
      end

      def run_with_output
        cmd = get_cmd
        return unless cmd
        result = `#{cmd}`
        set_result result
      end

      def run_with_result
        cmd = get_cmd
        return unless cmd
        result = system cmd
        set_result result
      end

    end
  end
end
