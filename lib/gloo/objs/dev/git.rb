# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An object that interacts with a git repository
#

module Gloo
  module Objs
    class Git < Gloo::Core::Obj
      
      KEYWORD = 'git_repo'
      KEYWORD_SHORT = 'git'

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
      # Get the path to the git repo (locally).
      # 
      def get_path
        return value
      end

      
      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      # 
      # Get a list of message names that this object receives.
      # 
      def self.messages
        return super + [ "validate", "check_changes", "get_changes" ]
      end

			# Check to see if the repo has changes.
      def msg_get_changes
        path = get_path
        if path and File.directory?( path )
					result = `cd #{path}; git status -s`
				end
				result = result ? result : ""
				$engine.heap.it.set_to result        
      end

			# Check to see if the repo has changes.
      def msg_check_changes
				result = false
        path = get_path
        if path and File.directory?( path )
					data = `cd #{path}; git status -s`
				  result = true unless ( data.strip.length == 0 )
				end

				$engine.heap.it.set_to result        
      end
      
      # Check to make sure this is a valide git repo.
      def msg_validate
				result = false
        path = get_path
        if path and File.directory?( path )
					result = File.exists? File.join( path, '.git' )
				end

				$engine.heap.it.set_to result        
      end
      
    end
  end
end
