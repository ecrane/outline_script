# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Show a CLI progress bar.
#
require 'tty-progressbar'

module Gloo
  module Objs
    class Bar < Gloo::Core::Obj

      KEYWORD = 'bar'.freeze
      KEYWORD_SHORT = 'bar'.freeze
      NAME = 'name'.freeze
      TOTAL = 'total'.freeze

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
      # Get the bar's name from the child object.
      #
      def name_value
        o = find_child NAME
        return '' unless o

        return o.value
      end

      #
      # Get the bar's total from the child object.
      #
      def total_value
        o = find_child TOTAL
        return 100 unless o

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
        fac.create_string NAME, '', self
        fac.create_int TOTAL, 100, self
      end

      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      #
      # Get a list of message names that this object receives.
      #
      def self.messages
        return super + %w[start advance stop]
      end

      #
      # Start the progress bar.
      #
      def msg_start
        msg = "#{name_value} [:bar] :percent"
        @bar = TTY::ProgressBar.new( msg, total: total_value )
      end

      #
      # Finish the progress bar.
      #
      def msg_stop
        @bar.finish
      end

      #
      # Advance the progress bar.
      #
      def msg_advance
        x = 1
        if @params&.token_count&.positive?
          expr = Gloo::Expr::Expression.new( @params.tokens )
          x = expr.evaluate.to_i
        end

        @bar.advance x
      end

      # ---------------------------------------------------------------------
      #    Help
      # ---------------------------------------------------------------------

      #
      # Get help for this object type.
      #
      def self.help
        return <<~TEXT
          BAR OBJECT TYPE
            NAME: bar
            SHORTCUT: bar

          DESCRIPTION
            CLI progress bar

          CHILDREN
            name - string
              The name of the progress bar.
            total - integer - 100
              The total for the bar.

          MESSAGES
            start - Start the bar.
            advance <amount> - Advance by the given amount.
            stop - Complete the bar.
        TEXT
      end

    end
  end
end
