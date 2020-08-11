# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2020 Eric Crane.  All rights reserved.
#
# Central Message Dispatch.
# Responsible for sending message to objects.
# All object messaging goes through here so we can uniformly
# manage things like checking to make sure object can
# receive the messages sent, handling errors, etc.
#

module Gloo
  module Exec
    class Dispatch

      #
      # Dispatch the given message to the given object.
      #
      def self.message( msg, to_obj, params = nil )
        $log.debug "----- Sending message #{msg} to #{to_obj.name}"

        if to_obj.can_receive_message? msg
          to_obj.send_message msg, params
        else
          $log.warn "Object #{to_obj.name} does not respond to #{msg}"
        end
      end

    end
  end
end
