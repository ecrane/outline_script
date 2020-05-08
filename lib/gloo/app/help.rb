# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Help system.
#

module Gloo
  module App
    class Help

      # Get text to display when the application is run
      # in HELP mode.
      def self.get_help_text
        return <<~TEXT
          NAME
          \tgloo

          DESCRIPTION
          \tGloo scripting language.  A scripting language built on ruby.
          \tMore information coming soon.

          SYNOPSIS
          \tgloo [global option] [file]

          GLOBAL OPTIONS
          \t--cli \t\t - Run in CLI mode
          \t--version \t - Show application version
          \t--help \t\t - Show this help page

        TEXT
      end

    end
  end
end
