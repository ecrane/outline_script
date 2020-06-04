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
    class HttpGet < Gloo::Core::Obj

      KEYWORD = 'http_get'.freeze
      KEYWORD_SHORT = 'get'.freeze
      URL = 'uri'.freeze
      PARAMS = 'params'.freeze
      RESULT = 'result'.freeze

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
      # Set the result of the API call.
      #
      def update_result( data )
        r = find_child RESULT
        return nil unless r

        r.set_value data
      end

      #
      # Get the URL for the service including all URL params.
      #
      def full_url_value
        p = ''
        params = find_child PARAMS
        params.children.each do |child|
          p << ( p.empty? ? '?' : '&' )

          # TODO: Quote URL params for safety
          p << "#{child.name}=#{child.value}"
        end
        return "#{uri_value}#{p}"
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
        fac.create( { :name => 'uri',
                      :type => 'string',
                      :value => 'https://web.site/',
                      :parent => self } )
        fac.create( { :name => 'params',
                      :type => 'container',
                      :value => nil,
                      :parent => self } )
        fac.create( { :name => 'result',
                      :type => 'string',
                      :value => nil,
                      :parent => self } )
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
        url = full_url_value
        $log.debug url
        update_result Gloo::Objs::HttpGet.invoke_request url
      end

      # ---------------------------------------------------------------------
      #    Static functions
      # ---------------------------------------------------------------------

      # Post the content to the endpoint.
      def self.invoke_request( url )
        uri = URI( url )
        use_ssl = uri.scheme.downcase.equal?( 'https' )
        Net::HTTP.start( uri.host, uri.port, :use_ssl => use_ssl ) do |http|
          request = Net::HTTP::Get.new uri
          response = http.request request # Net::HTTPResponse object
          return response.body
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
          HTTP_GET OBJECT TYPE
            NAME: http_get
            SHORTCUT: get

          DESCRIPTION
            Perform an HTTP Get.

          CHILDREN
            uri - string - 'https://web.site/'
              The URI for the HTTP Get request.
            params - container
              Collection of parameters for the HTTP Get.
            result - string
              The result of the request.  Whatever was returned from
              the HTTP Get call.

          MESSAGES
            run - Run the HTTP Get and update the result.
        TEXT
      end

    end
  end
end
