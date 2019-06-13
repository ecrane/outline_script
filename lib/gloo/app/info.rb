# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Application information such as Version and public name.
#

module Gloo
  module App
    class Info

      VERSION = "0.3.0"
      APP_NAME = "Gloo"

      def self.display_title
        return "#{APP_NAME}, version #{VERSION}"
      end

    end
  end
end

