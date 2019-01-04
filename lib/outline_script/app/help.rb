# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Help system.
#

module OutlineScript
  module App
    class Help

      # Get text to display when the application is run
      # in HELP mode.
      def self.get_help_text
        str = "\nNAME\n\toutline_script\n\n"
        str << "\nDESCRIPTION\n\tOutline scripting language.  A scripting language built on ruby.\n"
        str << "\tMore information coming soon.\n\n"
        str << "\nSYNOPSIS\n\toscript [global option] [file]\n\n"
        str << "\nGLOBAL OPTIONS\n"
        str << "\t--cli \t\t - Run in CLI mode\n"
        str << "\t--version \t - Show application version\n"
        str << "\t--help \t\t - Show this help page\n"
        str << "\n"
        return str
      end

    end
  end
end

