# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# An object that can send a message to a slack channel.
#
require 'net/http'
require 'uri'
require 'json'

module Gloo
  module Objs
    class Slack < Gloo::Core::Obj
      
      KEYWORD = 'slack'
      KEYWORD_SHORT = 'slack'
      URL = 'uri'
      MSG = 'message'
      USER = 'username'
      CHANNEL = 'channel'
      ICON = 'icon_emoji'

			ATTACHMENT = 'attachment'
			TITLE = 'title'
			TEXT = 'text'

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

			# 
      # Get the URI from the child object.
      # Returns nil if there is none.
      # 
      def get_attachment
        o = find_child ATTACHMENT
        return nil unless o
				
				title = o.find_child TITLE
				text = o.find_child TEXT
        return [{ 'title' => title.value, 'text' => text.value }]
      end
      
      # 
      # Get all the children of the body container and 
      # convert to JSON that will be sent in the HTTP body.
      # 
      def get_body_as_json
        h = { 'text' => find_child( MSG ).value,
          'username' => find_child( USER ).value,
          'channel' => find_child( CHANNEL ).value,
          'icon_emoji' => find_child( ICON ).value,
         }
				 
				 o = get_attachment
				 h[ 'attachments' ] = o if o
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
        fac.create URL, "string", "https://hooks.slack.com/services/...", self
        fac.create MSG, "string", "textual message", self
        fac.create USER, "string", "Slack Bot", self
        fac.create CHANNEL, "string", "general", self
        fac.create ICON, "string", ":ghost:", self
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
        Gloo::Objs::HttpPost.post_json uri, body, true
      end
      
    end
  end
end
