# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# JSON data.
#
require 'json'

module Gloo
  module Objs
    class Json < Gloo::Core::Obj

      KEYWORD = 'json'.freeze
      KEYWORD_SHORT = 'json'.freeze

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
      # Set the value with any necessary type conversions.
      #
      def set_value( new_value )
        self.value = new_value.to_s
      end

      #
      # Does this object support multi-line values?
      # Initially only true for scripts.
      #
      def multiline_value?
        return false
      end

      #
      # Get the number of lines of text.
      #
      def line_count
        return value.split( "\n" ).count
      end

      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      #
      # Get a list of message names that this object receives.
      #
      def self.messages
        return super + %w[get parse]
      end

      #
      # Get a value from the JSON data.
      # The additional parameter is the path to the value.
      #
      def msg_get
        if @params&.token_count&.positive?
          expr = Gloo::Expr::Expression.new( @params.tokens )
          data = expr.evaluate
        end
        return unless data

        h = JSON.parse( self.value )
        field = h[ data ]
        $engine.heap.it.set_to field
        return field
      end

      #
      # Parse the JSON data and put it in objects.
      # The additional parameter is the path to the destination
      # for the parsed objects.
      #
      def msg_parse
        if @params&.token_count&.positive?
          pn = Gloo::Core::Pn.new @params.tokens.first
          unless pn&.exists?
            $engine.err 'Destination path for parsed objects does not exist'
            return
          end
        else
          $engine.err 'Destination path for parsed objects is required'
          return
        end
        parent = pn.resolve

        json = JSON.parse( self.value )
        self.handle_json( json, parent)
      end

      #
      # Handle JSON, creating objects and setting values.
      # Note that this is a recursive function.
      #
      def handle_json( json, parent )
        if json.class == Hash
          json.each do |k, v|
            o = parent.find_add_child( k, 'untyped' )
            o.set_value v
          end
        elsif json.class == Array
          json.each_with_index do |o, index|
            child = parent.find_add_child( index.to_s, 'can' )
            handle_json( o, child )
          end
        end
      end

      # ---------------------------------------------------------------------
      #    Help
      # ---------------------------------------------------------------------

      #
      # Get help for this object type.
      #
      def self.help
        return <<~TEXT
          JSON OBJECT TYPE
            NAME: json
            SHORTCUT: json

          DESCRIPTION
            JSON data in a text string.

          CHILDREN
            None

          MESSAGES
            get - get a value from the JSON data
              Example: tell myjson to get ("title")
              The additional parameter is the path to the value.
            parse - parse the JSON data and put values in the
              object specified by the additional parameter
              Example: tell myjson to parse ("path.to.objects")
        TEXT
      end

    end
  end
end
