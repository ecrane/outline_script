# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# Play an audio file (MP3).
#

module Gloo
  module Objs
    class Play < Gloo::Core::Obj

      KEYWORD = 'play'.freeze
      KEYWORD_SHORT = 'play'.freeze

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
      #    Messages
      # ---------------------------------------------------------------------

      #
      # Get a list of message names that this object receives.
      #
      def self.messages
        return super + [ 'run' ]
      end

      # Play the audio file.
      def msg_run
        system "afplay #{value}"
      end

      # ---------------------------------------------------------------------
      #    Help
      # ---------------------------------------------------------------------

      #
      # Get help for this object type.
      #
      def self.help
        return <<~TEXT
          PLAY OBJECT TYPE
            NAME: play
            SHORTCUT: play

          DESCRIPTION
            Play an audio file, an MP3 for example.
            The value of the play object is the path to the audio file.

          CHILDREN
            None.

          MESSAGES
            run - Play the audio file.
        TEXT
      end

    end
  end
end
