# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# Move an object to a new parent.
#

module Gloo
  module Verbs
    class Move < Gloo::Core::Verb

      KEYWORD = 'move'.freeze
      KEYWORD_SHORT = 'mv'.freeze
      TO = 'to'.freeze

      #
      # Run the verb.
      #
      def run
        dst = lookup_dst
        return if dst.nil?

        o = lookup_obj
        return unless o

        o.parent.remove_child o
        dst.add_child o
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
      #    Helper functions
      # ---------------------------------------------------------------------

      #
      # Lookup the object that we're moving.
      #
      def lookup_obj
        arr = @tokens.before_token( TO )
        if arr.count == 1
          msg = 'object to move was not specified'
          $log.error msg, nil, $engine
        end

        name = arr[ 1 ]
        pn = Gloo::Core::Pn.new name
        o = pn.resolve

        unless o
          msg = "could not find object to move: #{name}"
          $log.error msg, nil, $engine
        end

        return o
      end

      #
      # Lookup destination, the new parent object.
      #
      def lookup_dst
        dst = @tokens.after_token( TO )
        unless dst
          msg = "'move' must include 'to' parent object"
          $log.error msg, nil, $engine
          return nil
        end

        pn = Gloo::Core::Pn.new dst
        o = pn.resolve
        unless o
          msg = "could not resolve '#{dst}'"
          $log.error msg, nil, $engine
          return nil
        end

        return o
      end

    end
  end
end
