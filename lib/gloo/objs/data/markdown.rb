# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# Markdown data.
#
require 'tty-markdown'
require 'tty-pager'

module Gloo
  module Objs
    class Markdown < Gloo::Core::Obj

      KEYWORD = 'markdown'.freeze
      KEYWORD_SHORT = 'md'.freeze

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
      # Set the value with any necessary type conversions.
      #
      def set_value( new_value )
        self.value = new_value.to_s
      end

      #
      # Does this object support multi-line values?
      # Initially only true for scripts.
      #
      def multiline_value?
        return false
      end

      #
      # Get the number of lines of text.
      #
      def line_count
        return value.split( "\n" ).count
      end

      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      #
      # Get a list of message names that this object receives.
      #
      def self.messages
        return super + %w[show page]
      end

      #
      # Show the markdown data in the terminal.
      #
      def msg_show
        puts TTY::Markdown.parse self.value
      end

      #
      # Show the markdown data in the terminal, paginated.
      #
      def msg_page
        return unless self.value

        md = TTY::Markdown.parse self.value
        # pager = TTY::Pager::SystemPager.new command: 'less -R'
        pager = TTY::Pager.new
        pager.page( md )
      end

      # ---------------------------------------------------------------------
      #    Help
      # ---------------------------------------------------------------------

      #
      # Get help for this object type.
      #
      def self.help
        return <<~TEXT
          MARKDOWN OBJECT TYPE
            NAME: markdown
            SHORTCUT: md

          DESCRIPTION
            Markdown data in a text string.

          CHILDREN
            None

          MESSAGES
            show - Show the markdown data in the terminal.
            page - Show the markdown data in the terminal, paginated.
        TEXT
      end

    end
  end
end
