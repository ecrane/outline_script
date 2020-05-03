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

    end
  end
end
