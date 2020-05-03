# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An object that can make a system call.
#

module Gloo
  module Objs
    class FileHandle < Gloo::Core::Obj

      KEYWORD = 'file'.freeze
      KEYWORD_SHORT = 'dir'.freeze

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


      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      #
      # Get a list of message names that this object receives.
      #
      def self.messages
        return super + [ "read", "write",
					"check_exists", "check_is_file", "check_is_dir" ]
      end

			def msg_read
				data = ""
        if value && File.file?( value )
					data = File.read( value )
					if @params && @params.token_count > 0
						pn = Gloo::Core::Pn.new @params.first
		        o = pn.resolve
						o.set_value data
					else
						$engine.heap.it.set_to data
					end
				end
			end

			def msg_write
				data = ""
        if value
					if @params && @params.token_count > 0
						expr = Gloo::Expr::Expression.new( @params.tokens )
						data = expr.evaluate
	        end
					File.write( value, data )
				end
			end

      # Check to see if the file exists.
      def msg_check_exists
				result = File.exists? value
				$engine.heap.it.set_to result
      end

			# Check to see if the file is a file.
      def msg_check_is_file
				result = File.file? value
				$engine.heap.it.set_to result
      end

			# Check to see if the file is a directory.
      def msg_check_is_dir
				result = File.directory? value
				$engine.heap.it.set_to result
      end

    end
  end
end
