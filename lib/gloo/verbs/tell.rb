# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Create an object, optionally of a type.
#

module Gloo
  module Verbs
    class Tell < Gloo::Core::Verb

      KEYWORD = 'tell'.freeze
      KEYWORD_SHORT = '->'.freeze
      TO = 'to'.freeze

      #
      # Run the verb.
      #
      def run
        name = @tokens.second
        msg = @tokens.after_token( TO )
        pn = Gloo::Core::Pn.new name
        o = pn.resolve

        if o
          o.send_message( msg, @params )
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
