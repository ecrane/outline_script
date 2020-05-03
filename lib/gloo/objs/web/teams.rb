# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An object that can send a message to a Teams webhook.
#
require 'net/http'
require 'uri'
require 'json'

module Gloo
  module Objs
    class Teams < Gloo::Core::Obj

      KEYWORD = 'teams'.freeze
      KEYWORD_SHORT = 'team'.freeze
      URL = 'uri'.freeze
      MSG = 'message'.freeze
      TITLE = 'title'.freeze
      COLOR = 'color'.freeze

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
      def get_uri
        uri = find_child URL
        return nil unless uri
        return uri.value
      end

			# Get the color value.
			def get_color
				c = find_child COLOR
        return nil unless c
        return c.value
			end

      #
      # Get all the children of the body container and
      # convert to JSON that will be sent in the HTTP body.
      #
      def get_body_as_json
        h = { 'title' => find_child( TITLE ).value,
          'text' => find_child( MSG ).value
         }

				color = get_color
				if color
				 h[ 'themeColor' ] = color
			 end

        return h.to_json
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
        fac.create URL, "string", "https://outlook.office.com/webhook/...", self
        fac.create TITLE, "string", "", self
				fac.create COLOR, "color", "008000", self
				fac.create MSG, "string", "", self
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

      # Post the content to the endpoint.
      def msg_run
        uri = get_uri
        return unless uri

        body = get_body_as_json
        # puts body

        Gloo::Objs::HttpPost.post_json uri, body, true
      end

    end
  end
end
