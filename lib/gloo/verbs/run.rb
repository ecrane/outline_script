# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Run a script.
# Shortcut for telling a script to run.
#

module Gloo
  module Verbs
    class Run < Gloo::Core::Verb

      KEYWORD = 'run'.freeze
      KEYWORD_SHORT = 'r'.freeze

      #
      # Run the verb.
      #
      def run
        name = @tokens.second
        pn = Gloo::Core::Pn.new name
        o = pn.resolve

        if o
          o.send_message 'run'
        else
          $log.error "Could not send message to object.  Bad path: #{name}"
        end
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
          RUN VERB
            NAME: run
            SHORTCUT: r

          DESCRIPTION
            Run a script or other object.
            This is the same as sending a 'run' message to the object.

          SYNTAX
            run <path.to.object>

          PARAMETERS
            path.to.object - Reference to the object which will be run.

          RESULT
            The result depends on the object that is run.

          ERRORS
            The errors depend on the object that is run.
        TEXT
      end

    end
  end
end
