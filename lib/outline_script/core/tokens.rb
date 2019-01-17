# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An ordered list of tokens.
# The list of tokens makes up a command.
#

module OutlineScript
  module Core
    class Tokens
      
      attr_reader :cmd, :tokens
      
      # Set up the tokens.
      def initialize( cmd_string )
        @cmd = cmd_string
        @tokens = @cmd.split( " " )
      end
      
      # Get the verb (the first word)
      def verb
        return @tokens.first
      end
            
    end
  end
end
