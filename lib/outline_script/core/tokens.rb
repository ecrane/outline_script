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
            
      def tokenize_other
        str = @cmd
        
        while str.length > 0
          puts "str: '#{str}' - token count = #{@tokens.count}"
          i = str.index ' '
          if i
            first = str[0]
            if ( first == "'" ) || ( first == '"' )
              i = str.index( first, i+1 )
            end
            
            t = str[ 0..i-1 ]
            add_token t
            str = str[ i..-1 ]
            puts "t = '#{t}' -- str = '#{str}'"
          else
            add_token str
            str = ""
          end
        end
      end
      
      # Add a token to the list.
      def add_token str
        return unless str
        if ( str.start_with?( "'" ) || str.start_with?( '"' ) )
          if str.end_with?( ' ' )
            @tokens << str[0..-2]
          else
            @tokens << str
          end
        else
          @tokens << str.strip
        end
      end
      
      # Create a list of token from the given string.
      def tokenize_old cmd_string
        tokens = []
        in_str = false
        str_literal = nil
        cmd_string.split( " " ).each do |str|
          puts "str: '#{str}'"
          puts "str_literal: '#{str_literal}'"
          if ( str.start_with?( "'" ) || str.start_with?( '"' ) ) && ! in_str
            in_str = str[0] 
            str_literal = ""
          end
          
          ( str_literal << str ) if in_str
          puts "str_literal: '#{str_literal}'"

          if in_str
            if str == in_str
              str_literal << " "
            elsif str.end_with?( in_str )
              in_str = false
            else
              str_literal << " "
            end
          end
          puts "str_literal: '#{str_literal}' - in_str '#{in_str}'"          
          puts "1: '#{! str_literal.nil?}' - 2 '#{! in_str}'"
          if ( ! str_literal.nil? ) && ( ! in_str )
            puts "done"
            tokens << str_literal
            str_literal = nil
          elsif ! in_str
            tokens << str
          end
          puts "str_literal: '#{str_literal}'"
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
            
    end
  end
end
