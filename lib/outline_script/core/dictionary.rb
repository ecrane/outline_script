# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# A dictionary of Objects and Verbs.
#
require 'singleton'

module OutlineScript
  module Core
    class Dictionary
      
      include Singleton
      
      attr_reader :verbs
      
      # Set up the object dictionary.
      def initialize()
        @verbs = {}
        @verb_references = []
        @obj_references = []
      end
      
      # Register a verb.
      def register_verb subclass
        @verb_references << subclass
      end

      # Initialize verbs and objects in the dictionary.
      def init
        $log.debug "initializing dictionaries"
        init_verbs
      end
      
      # Init the list of verbs.
      def init_verbs
        $log.debug "initializing #{@verb_references.count} verbs"
        @verb_references.each do |v|
          $log.debug  v
          @verbs[ v.keyword ] = v
          # v.send( :new ).run
        end
      end
      
      # Is the given word a verb?
      def is_verb? word
        return false unless word
        return @verbs.key?( word.downcase )
      end
      
      # Find the verb by name.
      def find_verb verb
        return nil unless verb
        return nil unless is_verb?( verb )
        return @verbs[ verb.downcase ]
      end
      
    end
  end
end
