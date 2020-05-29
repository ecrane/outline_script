# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Show colorized output.
#
require 'colorized_string'

module Gloo
  module Objs
    class Colorize < Gloo::Core::Obj

      KEYWORD = 'colorize'.freeze
      KEYWORD_SHORT = 'color'.freeze

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
        fac.create( { :name => 'white',
                      :type => 'string',
                      :value => '',
                      :parent => self } )
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

      # Run the system command.
      def msg_run
        msg = ''
        children.each do |o|
          msg += ColorizedString[ o.value_display ].colorize( o.name.to_sym )
        end
        $log.show msg
        $engine.heap.it.set_to msg.to_s
      end

      # ---------------------------------------------------------------------
      #    Help
      # ---------------------------------------------------------------------

      #
      # Get help for this object type.
      #
      def self.help
        return <<~TEXT
          COLORIZE OBJECT TYPE
            NAME: colorize
            SHORTCUT: color

          DESCRIPTION
            The Colorize object can be used to write output in color.
            The Colorize container can contain multiple strings, each
            one can have a different color as specified by the names
            of the children.

          CHILDREN
            <color> - string - no default value
              The name of the child or children is the color.
              The string's value is what will be written out.

          MESSAGES
            run - Output the string in the color specified.
        TEXT
      end

    end
  end
end
