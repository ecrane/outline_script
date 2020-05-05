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
        return super + %w[read write check_exists check_is_file check_is_dir]
      end

      def msg_read
        return unless value && File.file?( value )

        data = File.read( value )
        if @params&.token_count&.positive?
          pn = Gloo::Core::Pn.new @params.first
          o = pn.resolve
          o.set_value data
        else
          $engine.heap.it.set_to data
        end
      end

      def msg_write
        data = ''
        return unless value

        if @params&.token_count&.positive?
          expr = Gloo::Expr::Expression.new( @params.tokens )
          data = expr.evaluate
        end
        File.write( value, data )
      end

      # Check to see if the file exists.
      def msg_check_exists
        result = File.exist? value
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
