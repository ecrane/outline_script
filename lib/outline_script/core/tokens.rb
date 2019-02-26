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
        @tokens = tokenize cmd_string
      end
      
      # Create a list of token from the given string.
      def tokenize cmd_string
        tokens = []
        in_str = false
        str_literal = nil
        cmd_string.split( " " ).each do |str|
          if str.start_with?( "'" ) || str.start_with?( '"' )
            in_str = str[0] 
          end
          
          if in_str
            str_literal = "" unless str_literal
            str_literal << str
          end
          
          if in_str 
            if str.end_with?( in_str )
              in_str = false
            else
              str_literal << " "
            end
          end
          
          if str_literal && ( ! in_str )
            tokens << str_literal
            str_literal = nil
          elsif ! in_str
            tokens << str
          end
        end
        return tokens
      end
      
      # Get the number of tokens
      def token_count
        return @tokens.size
      end
      
      # Get the verb (the first word)
      def verb
        return first
      end

      # Get the first token.
      def first
        return @tokens.first if @tokens
      end

      # Get the last token.
      def last
        return @tokens.last if @tokens
      end
      
      # Get the second token.
      def second
        return @tokens[1] if @tokens && @tokens.size > 0
      end

      def at index
        return @tokens[index] if @tokens && @tokens.size >= index
      end
      
      # Get the index of the given token.
      def index_of token
        return nil unless @tokens
        return @tokens.find_index { |o| o.casecmp( token ) == 0 }
      end
      
      # Get the item after a given token.
      def after_token token
        i = index_of token
        if i && @tokens && @tokens.size > ( i+1 ) 
          return @tokens[ i+1 ]
        end
        return nil
      end
            
    end
  end
end
