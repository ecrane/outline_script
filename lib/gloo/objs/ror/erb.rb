# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An object that evaluate a ruby statement.
#
require 'erb'

module Gloo
  module Objs
    class Erb < Gloo::Core::Obj

      KEYWORD = 'erb'.freeze
      KEYWORD_SHORT = 'erb'.freeze
      TEMPLATE = 'template'.freeze
      PARAMS = 'params'.freeze
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
      # Get the ERB template.
      #
      def get_template
        tmpl = find_child TEMPLATE
        return nil unless tmpl
        return tmpl.value
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
      # Get a hash with parameters for the ERB render.
      #
      def get_param_hash
        h = {}

        body = find_child PARAMS
        body.children.each do |child|
          h[ child.name ] = child.value
        end

        return h
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
        fac.create "template", "text", "", self
        fac.create "params", "container", nil, self
        fac.create "result", "text", nil, self
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
        tmpl = get_template
        return unless tmpl
        render = ERB.new( tmpl )
        set_result render.result_with_hash( get_param_hash )
      end

    end
  end
end
