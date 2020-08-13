# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An object that can post JSON to a URI.
#
require 'net/http'
require 'uri'
require 'json'

module Gloo
  module Objs
    class HttpPost < Gloo::Core::Obj

      KEYWORD = 'http_post'.freeze
      KEYWORD_SHORT = 'post'.freeze
      URL = 'uri'.freeze
      BODY = 'body'.freeze

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
      def uri_value
        uri = find_child URL
        return nil unless uri

        return uri.value
      end

      #
      # Get all the children of the body container and
      # convert to JSON that will be sent in the HTTP body.
      #
      def body_as_json
        h = {}

        body = find_child BODY
        body.children.each do |child|
          child_val = Gloo::Objs::Alias.resolve_alias( child )
          h[ child.name ] = child_val.value
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
        fac.create_string URL, 'https://web.site/', self
        fac.create_can BODY, self
      end

      # ---------------------------------------------------------------------
      #    Messages
      # ---------------------------------------------------------------------

      #
      # Get a list of message names that this object receives.
      #
      def self.messages
        return super + [ 'run' ]
      end

      # Post the content to the endpoint.
      def msg_run
        uri = uri_value
        return unless uri

        $log.debug "posting to: #{uri}"
        body = self.body_as_json
        $log.debug "posting body: #{body}"
        use_ssl = uri.downcase.start_with?( 'https' )
        Gloo::Objs::HttpPost.post_json uri, body, use_ssl
      end

      # ---------------------------------------------------------------------
      #    Static functions
      # ---------------------------------------------------------------------

      # Post the content to the endpoint.
      def self.post_json( url, body, use_ssl = true )
        # Structure the request
        uri = URI.parse( url )
        request = Net::HTTP::Post.new( uri.path )
        request.content_type = 'application/json'
        request.body = body
        n = Net::HTTP.new( uri.host, uri.port )
        n.use_ssl = use_ssl

        # Send the payload to the endpoint.
        result = n.start { |http| http.request( request ) }
        $log.debug result.code
        $log.debug result.message
      end

      # ---------------------------------------------------------------------
      #    Help
      # ---------------------------------------------------------------------

      #
      # Get help for this object type.
      #
      def self.help
        return <<~TEXT
          HTTP_POST OBJECT TYPE
            NAME: http_post
            SHORTCUT: post

          DESCRIPTION
            Perform an HTTP Post.

          CHILDREN
            uri - string - 'https://web.site/'
              The URI for the HTTP Post.
            body - container
              Collection of parameters for the HTTP Post.

          MESSAGES
            run - Run the HTTP Post sending the body data to the
              endpoint specified in the URI.
        TEXT
      end

    end
  end
end
