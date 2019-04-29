# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An ordered list of tokens.
# The list of tokens makes up a command.
#

module Gloo
  module Core
    class Tokens
      
      attr_reader :cmd, :tokens
      
      # Set up the tokens.
      def initialize( cmd_string )
        @cmd = cmd_string
        @tokens = []
        tokenize @cmd
      end
      
      # Create a list of token from the given string.
      def tokenize str
        if str.index( '"' )
          i = str.index( '"' )
          j = str.index( '"', i+1 )
          j = str.length unless j
          
          tokenize( str[ 0..i-1 ] ) if i > 1
          @tokens << str[ i..j ]
          tokenize( str[ j+1..-1 ] ) if j+1 < str.length
        elsif str.index( "'" )
          i = str.index( "'" )
          j = str.index( "'", i+1 )
          j = str.length unless j

          tokenize( str[ 0..i-1 ] ) if i > 1
          @tokens << str[ i..j ]
          tokenize( str[ j+1..-1 ] ) if j+1 < str.length
        else
          str.strip.split( " " ).each { |t| @tokens << t }
        end
      end
      
      # Get the number of tokens
      def token_count
        return @tokens.size
      end
      
      # Get the verb (the first word)
      def verb
        return first
      end

      # Get all tokens except the first.
      def params
        return @tokens[ 1..-1 ]
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

      # Get the item after a given token.
      def before_token token
        i = index_of token
        if i && @tokens && @tokens.size >= ( i ) 
          return @tokens[ 0..i-1 ]
        end
        return nil
      end
            
    end
  end
end
