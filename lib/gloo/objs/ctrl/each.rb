# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# A looping construct...do something for each whatever in something.
# This object has several possible uses:
#   - each word in a string
#   - each line in a string
#   - each file in a directory
#   - each git repo in a directory
#

module Gloo
  module Objs
    class Each < Gloo::Core::Obj
      
      KEYWORD = 'each'
      KEYWORD_SHORT = 'each'
      WORD = 'word'
      LINE = 'line'
      FILE = 'file'
      REPO = 'repo'
      IN = 'IN'
      DO = 'do'

      # 
      # The name of the object type.
      # 
      def self.typename
        return KEYWORD
      end

      # 
      # The short name of the object type.
      # 
      def self.short_typename
        return KEYWORD_SHORT
      end
      
      # 
      # Get the URI from the child object.
      # Returns nil if there is none.
      # 
      def get_in
        o = find_child IN
        return nil unless o
        return o.value
      end
      
      # Run the do script once.
      def run_do
        o = find_child DO
        if o.can_receive_message? "run"
          o.send_message "run"
        end
      end

      

      # ---------------------------------------------------------------------
      #    Children
      # ---------------------------------------------------------------------

      # Does this object have children to add when an object
      # is created in interactive mode?
      # This does not apply during obj load, etc.
      def add_children_on_create?
        return true
      end
      
      # Add children to this object.
      # This is used by containers to add children needed 
      # for default configurations.
      def add_default_children
        fac = $engine.factory
        fac.create "word", "string", "", self
        fac.create "in", "string", "", self
        fac.create "do", "script", "", self
      end

      
      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      # 
      # Get a list of message names that this object receives.
      # 
      def self.messages
        return super + [ "run" ]
      end
      
      # Run the system command.
      def msg_run
        if each_word?
          run_each_word
        elsif each_line?
          run_each_line
        elsif each_repo?
          run_each_repo
        end
      end
      
      
      # ---------------------------------------------------------------------
      #    Word
      # ---------------------------------------------------------------------

      # Is it set up to run for each word?
      # If there is a child object by the name "word"
      # then we will loop for each word in the string.
      def each_word?
        o = find_child WORD
        return true if o
        return false
      end

      # Run for each word.
      def run_each_word
        str = get_in
        return unless str
        str.split( " " ).each do |word|
          set_word word
          run_do
        end
      end
      
      # Set the value of the word.
      def set_word word
        o = find_child WORD
        return unless o
        o.set_value word
      end
      

      # ---------------------------------------------------------------------
      #    Line
      # ---------------------------------------------------------------------

      # Is it set up to run for each line?
      # If there is a child object by the name "line"
      # then we will loop for each line in the string.
      def each_line?
        o = find_child LINE
        return true if o
        return false
      end
      
      # Run for each line.
      def run_each_line
        str = get_in
        return unless str
        str.split( "\n" ).each do |line|
          set_line line
          run_do
        end
      end
      
      # Set the value of the word.
      def set_line line
        o = find_child LINE
        return unless o
        o.set_value line
      end



      # ---------------------------------------------------------------------
      #    Git Repo
      # ---------------------------------------------------------------------

      # Is it set up to run for each git repo?
      # If there is a child object by the name "repo"
      # then we will loop for each repo in the directory.
      def each_repo?
        o = find_child REPO
        return true if o
        return false
      end
      
      def find_all_git_projects( path )
        path.children.collect do |f|
          if f.directory? && ( File.basename( f ) == '.git' )
            File.dirname( f )
          elsif f.directory?
            find_all_git_projects( f )
          end
        end.flatten.compact
      end

      # Run for each line.
      def run_each_repo
        path = get_in
        return unless path
        path = Pathname.new( path )
        repos = find_all_git_projects( path )
        repos.each do |o|
          set_repo o
          run_do
        end
      end
      
      # Set the value of the repo.
      # This is a path to the repo.
      def set_repo path
        o = find_child REPO
        return unless o
        o.set_value path
      end

    end
  end
end