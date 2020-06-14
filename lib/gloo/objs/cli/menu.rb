# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# A CLI menu.
# The menu contains a collection of menu items, a prompt
# and an option to loop until done.
#

module Gloo
  module Objs
    class Menu < Gloo::Core::Obj

      KEYWORD = 'menu'.freeze
      KEYWORD_SHORT = 'menu'.freeze
      PROMPT = 'prompt'.freeze
      ITEMS = 'items'.freeze
      LOOP = 'loop'.freeze

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
      # Get the value of the prompt child object.
      # Returns nil if there is none.
      #
      def prompt_value
        o = find_child PROMPT
        return '> ' unless o

        return o.value
      end

      #
      # Get the value of the loop child object.
      # Should we keep looping or should we stop?
      #
      def loop?
        o = find_child LOOP
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
        fac.create_string PROMPT, '> ', self
        fac.create_can ITEMS, self
        fac.create_bool LOOP, true, self
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
      # Show the menu options, and prompt for user input.
      #
      def msg_run
        loop do
          show_options
          cmd = $prompt.ask( prompt_value )
          run_command cmd
          break unless loop?
        end
      end

      # ---------------------------------------------------------------------
      #    Menu actions
      # ---------------------------------------------------------------------

      #
      # Show the list of menu options.
      #
      def show_options
        o = find_child ITEMS
        return unless o

        o.children.each do |mitem|
          puts " #{mitem.shortcut_value} - #{mitem.description_value}"
        end
      end

      #
      # Find the command matching user input.
      #
      def find_cmd( cmd )
        o = find_child ITEMS
        return nil unless o

        o.children.each do |mitem|
          return mitem if mitem.shortcut_value.downcase == cmd.downcase
        end

        return nil
      end

      #
      # Run the selected command.
      #
      def run_command( cmd )
        obj = find_cmd cmd

        unless obj
          puts "#{cmd} is not a valid option"
          return
        end

        script = obj.do_script
        return unless script

        s = Gloo::Core::Script.new script
        s.run
      end

      # ---------------------------------------------------------------------
      #    Help
      # ---------------------------------------------------------------------

      #
      # Get help for this object type.
      #
      def self.help
        return <<~TEXT
          MENU OBJECT TYPE
            NAME: menu
            SHORTCUT: menu

          DESCRIPTION
            A CLI menu.
            This can be used for the main loop of a CLI application.

          CHILDREN
            prompt - string - '> '
              The shortcut may be used to select the  menu item.
            items - container
              A textual description of the menu item action.
            loop - boolean
              The script that will be run if the menu item is selected.

          MESSAGES
            run - Show the options and the the prompt.
              Then run the script for the user's selection.
              Optionally repeat as long as the loop child is true.
        TEXT
      end

    end
  end
end
