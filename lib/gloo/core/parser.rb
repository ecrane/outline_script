# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# The Parser.
# Can parse single line commands or files.
#

module Gloo
  module Core
    class Parser
      
      # Set up the parser.
      def initialize()
        $log.debug "parser intialized..."
      end
      
      
      # Parse a command from the immediate execution context.
      def parse_immediate cmd
        tokens = Gloo::Core::Tokens.new( cmd )
        dic = Gloo::Core::Dictionary.instance
        verb = dic.find_verb( tokens.verb )
        return verb.new( tokens ) if verb
          
        $log.error "Verb '#{tokens.verb}' was not found."
        return nil
      end
      
      # Parse a command and then run it if it parsed correctly.
      def run cmd
        v = parse_immediate( cmd )
        v.run if v
      end
      
    end
  end
end
