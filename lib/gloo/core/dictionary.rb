# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# A dictionary of Objects and Verbs.
#
require 'singleton'

module Gloo
  module Core
    class Dictionary

      include Singleton

      attr_reader :verbs, :objs, :keywords

      #
      # Set up the object dictionary.
      #
      def initialize
        @verbs = {}
        @objs = {}
        @verb_references = []
        @obj_references = []
        @keywords = []
      end

      #
      # Register a verb.
      #
      def register_verb( subclass )
        @verb_references << subclass
      end

      #
      # Register an object type.
      #
      def register_obj( subclass )
        @obj_references << subclass
      end

      #
      # Initialize verbs and objects in the dictionary.
      #
      def init
        $log.debug 'initializing dictionaries'
        init_verbs
        init_objs
      end

      #
      # Is the given word an object type?
      #
      def obj?( word )
        return false unless word

        return @objs.key?( word.downcase )
      end

      #
      # Find the object type by name.
      #
      def find_obj( word )
        return nil unless word
        return nil unless obj?( word )

        return @objs[ word.downcase ]
      end

      #
      # Is the given word a verb?
      #
      def verb?( word )
        return false unless word

        return @verbs.key?( word.downcase )
      end

      #
      # Find the verb by name.
      #
      def find_verb( verb )
        return nil unless verb
        return nil unless verb?( verb )

        return @verbs[ verb.downcase ]
      end

      #
      # Get the list of verbs, sorted.
      #
      def get_obj_types
        return @obj_references.sort { |a, b| a.typename <=> b.typename }
      end

      #
      # Get the list of verbs, sorted.
      #
      def get_verbs
        return @verb_references.sort { |a, b| a.keyword <=> b.keyword }
      end

      #
      # Lookup the keyword by name or shortcut.
      # Return the keyword (name) or nil if it is not found.
      #
      def lookup_keyword( key )
        v = find_verb key
        return v.keyword if v

        o = find_obj key
        return o.typename if o

        return nil
      end

      #
      # Show a list of all keywords.
      # This includes verbs and objects, names and shortcuts.
      #
      def show_keywords
        str = ''
        @keywords.sort.each_with_index do |k, i|
          str << k.ljust( 20, ' ' )
          if ( ( i + 1 ) % 6 ).zero?
            puts str
            str = ''
          end
        end
      end

      # ---------------------------------------------------------------------
      #    Private
      # ---------------------------------------------------------------------

      private

      #
      # Add a keyword to the keyword list.
      # Report an error if the keyword is already in the list.
      #
      def add_key( keyword )
        if @keywords.include?( keyword )
          $log.error "duplicate keyword '#{keyword}'"
          return
        end

        @keywords << keyword
      end

      #
      # Init the list of objects.
      #
      def init_objs
        $log.debug "initializing #{@obj_references.count} objects"
        @obj_references.each do |o|
          $log.debug o
          @objs[ o.typename ] = o
          @objs[ o.short_typename ] = o
          add_key o.typename
          add_key o.short_typename if o.typename != o.short_typename
        end
      end

      #
      # Init the list of verbs.
      #
      def init_verbs
        $log.debug "initializing #{@verb_references.count} verbs"
        @verb_references.each do |v|
          $log.debug v
          @verbs[ v.keyword ] = v
          @verbs[ v.keyword_shortcut ] = v
          # v.send( :new ).run
          add_key v.keyword
          add_key v.keyword_shortcut if v.keyword != v.keyword_shortcut
        end
      end

    end
  end
end
