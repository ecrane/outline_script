# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# The Object Heap.
# The collection of objects that are currently in play in
# the running engine.
#

module OutlineScript
  module Core
    class Heap
      
      # The context is a reference to an object, usually a container.
      # The context will be the root by default.
      attr_reader :context
      
      # TODO:  Do I need a running script context?
      # how to resolve relative reference.
      
      attr_reader :it, :root
      
      # Set up the object heap.
      def initialize()
        $log.debug "object heap intialized..."
        
        @root = OutlineScript::Objs::Container.new
        @root.name = "root"
        
        @context = Pn.root
        @it = It.new
      end
      
      
    end
  end
end
