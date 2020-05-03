# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Show a CLI prompt and collect user input.
#

module Gloo
  module Objs
    class Prompt < Gloo::Core::Obj

      KEYWORD = 'prompt'.freeze
      KEYWORD_SHORT = 'ask'.freeze
      PROMPT = 'prompt'.freeze
      RESULT = 'result'.freeze

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
      def get_prompt
        o = find_child PROMPT
        return nil unless o
        return o.value
      end

      #
      # Set the result of the system call.
      #
      def set_result data
        r = find_child RESULT
        return nil unless r
        r.set_value data
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
        fac.create "prompt", "string", "> ", self
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
        prompt = get_prompt
        return unless prompt
        result = $prompt.ask( prompt )
        set_result result
      end

    end
  end
end
