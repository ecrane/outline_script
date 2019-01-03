# Author::    Eric Crane  (mailto:eric.crane@mac.com)
# Copyright:: Copyright (c) 2019 Eric Crane.  All rights reserved.
#
# Start the Engine.
#

path = File.dirname( File.absolute_path( __FILE__ ) )
root = File.join( path, "outline_script", "**/*.rb" )
Dir.glob( root ) { |ruby_file| require ruby_file }

module OutlineScript  

  def self.run
    params = []
    ( params << "--cli" ) if ARGV.count == 0
    OutlineScript::App::Engine.new( params ).start
  end

end
