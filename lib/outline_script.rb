# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Start the Engine.
#

require 'outline_script/app/engine'

module OutlineScript  

  def self.run
    OutlineScript::App::Engine.new.start
  end

end
