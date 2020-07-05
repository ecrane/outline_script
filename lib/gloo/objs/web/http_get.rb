# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An object that can post JSON to a URI.
#
require 'net/http'
require 'uri'
require 'json'
require 'openssl'

module Gloo
  module Objs
    class HttpGet < Gloo::Core::Obj

      KEYWORD = 'http_get'.freeze
      KEYWORD_SHORT = 'get'.freeze
      URL = 'uri'.freeze
      PARAMS = 'params'.freeze
      RESULT = 'result'.freeze
      SKIP_SSL_VERIFY = 'skip_ssl_verify'.freeze

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
      # Should we skip SSL verification during the request?
      #
      def skip_ssl_verify?
        skip = find_child SKIP_SSL_VERIFY
        return false unless skip

        return skip.value
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

          child = Gloo::Objs::Alias.resolve_alias( child )

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
        r = Gloo::Objs::HttpGet.invoke_request( url, self.skip_ssl_verify? )
        update_result r
      end

      # ---------------------------------------------------------------------
      #    Static functions
      # ---------------------------------------------------------------------

      # Post the content to the endpoint.
      def self.invoke_request( url, skip_ssl_verify = false )
        uri = URI( url )
        params = { use_ssl: uri.scheme == 'https' }

        params[ :verify_mode ] = ::OpenSSL::SSL::VERIFY_NONE if skip_ssl_verify

        Net::HTTP.start( uri.host, uri.port, params ) do |http|
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
            skip_ssl_verify - boolean (optional)
              Skip the SSL verification as part of the request.

          MESSAGES
            run - Run the HTTP Get and update the result.
        TEXT
      end

    end
  end
end
