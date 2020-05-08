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

      attr_reader :verbs, :objs

      # Set up the object dictionary.
      def initialize
        @verbs = {}
        @objs = {}
        @verb_references = []
        @obj_references = []
      end

      # Register a verb.
      def register_verb( subclass )
        @verb_references << subclass
      end

      # Register an object type.
      def register_obj( subclass )
        @obj_references << subclass
      end

      # Initialize verbs and objects in the dictionary.
      def init
        $log.debug 'initializing dictionaries'
        init_verbs
        init_objs
      end

      # Init the list of verbs.
      def init_objs
        $log.debug "initializing #{@obj_references.count} objects"
        @obj_references.each do |o|
          $log.debug o
          @objs[ o.typename ] = o
          @objs[ o.short_typename ] = o
        end
      end

      # Is the given word an object type?
      def is_obj?( word )
        return false unless word

        return @objs.key?( word.downcase )
      end

      # Find the object type by name.
      def find_obj( word )
        return nil unless word
        return nil unless is_obj?( word )

        return @objs[ word.downcase ]
      end

      # Init the list of verbs.
      def init_verbs
        $log.debug "initializing #{@verb_references.count} verbs"
        @verb_references.each do |v|
          $log.debug v
          @verbs[ v.keyword ] = v
          @verbs[ v.keyword_shortcut ] = v
          # v.send( :new ).run
        end
      end

      # Is the given word a verb?
      def is_verb?( word )
        return false unless word

        return @verbs.key?( word.downcase )
      end

      # Find the verb by name.
      def find_verb( verb )
        return nil unless verb
        return nil unless is_verb?( verb )

        return @verbs[ verb.downcase ]
      end

      # Get the list of verbs, sorted.
      def get_obj_types
        return @obj_references.sort { |a, b| a.typename <=> b.typename }
      end

      # Get the list of verbs, sorted.
      def get_verbs
        return @verb_references.sort { |a, b| a.keyword <=> b.keyword }
      end

    end
  end
end
