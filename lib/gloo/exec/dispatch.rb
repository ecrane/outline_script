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
        $log.debug "Dispatch message #{msg} to #{to_obj.name}"
        a = Gloo::Exec::Action.new msg, to_obj, params
        Gloo::Exec::Dispatch.action a
      end

      #
      # Dispatch an action.
      #
      def self.action( action )
        unless action.valid?
          $log.warn "Object #{action.to.name} does not respond to #{action.msg}"
        end

        $engine.exec_env.push_action action
        $log.debug "Sending message #{action.msg} to #{action.to.name}"
        action.dispatch
        $engine.exec_env.pop_action
      end

    end
  end
end
