# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Save an object to a file or other persistance mechcanism.
#

module Gloo
  module Verbs
    class Save < Gloo::Core::Verb

      KEYWORD = 'save'.freeze
      KEYWORD_SHORT = '>'.freeze

      #
      # Run the verb.
      #
      def run
        # TODO:  Not currently using folders or keeping
        # track of where the object was loaded from.
        $engine.persist_man.save @tokens.second
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
          SAVE VERB
            NAME: save
            SHORTCUT: >

          DESCRIPTION
            Stop running the gloo application.
            Cleanup and shutdown.

          SYNTAX
            save <path.to.object>
            Save a previously loaded object.  The path will be for the
            root level object that was loaded earlier.

          PARAMETERS
            path.to.object - Name of the object file that is to be saved.

          RESULT
            The file is updated with the latest object state.

          ERRORS
            None
        TEXT
      end

    end
  end
end
