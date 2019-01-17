# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# The Parser.
# Can parse single line commands or files.
#

module OutlineScript
  module Core
    class Parser
      
      # Set up the parser.
      def initialize()
        $log.debug "parser intialized..."
      end
      
      
      # Parse a command from the immediate execution context.
      def parse_immediate cmd
        tokens = OutlineScript::Core::Tokens.new( cmd )
        dic = OutlineScript::Core::Dictionary.instance
        verb = dic.find_verb( tokens.verb )
        return verb.new( tokens ) if verb
          
        $log.error "Verb '#{tokens.verb}' was not found."
        return nil
      end
      
    end
  end
end
