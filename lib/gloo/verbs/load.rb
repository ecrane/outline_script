# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Save an object to a file or other persistance mechcanism.
#

module Gloo
  module Verbs
    class Load < Gloo::Core::Verb

      KEYWORD = 'load'.freeze
      KEYWORD_SHORT = '<'.freeze

      #
      # Run the verb.
      #
      def run
        fn = @tokens.second
        $log.debug "Getting ready to load file: #{fn}"
        $engine.persist_man.load fn
      end

      #
      # Get the Verb's keyword.
      #
      def self.keyword
        return KEYWORD
      end

      #
      # Get the Verb's keyword shortcut.
      #
      def self.keyword_shortcut
        return KEYWORD_SHORT
      end

      # ---------------------------------------------------------------------
      #    Help
      # ---------------------------------------------------------------------

      #
      # Get help for this verb.
      #
      def self.help
        return <<~TEXT
          LOAD VERB
            NAME: load
            SHORTCUT: <

          DESCRIPTION
            Load an object file.
            The file's path should be provided from the gloo project folder
            as the root directory.
            Using * instead of a file name will load all gloo files in the folder.

          SYNTAX
            load <file_name>

          PARAMETERS
            file_name - Name of the object file that is to be loaded.

          RESULT
            Objects are loaded into the heap.
            on_load scripts are run within the loaded objects.

          ERRORS
            If the file specified can't be found or can't be loaded,
            an error condition will result.
        TEXT
      end

    end
  end
end
