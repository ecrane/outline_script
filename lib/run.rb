#
# The following can be used to run the application in CLI mode
# in development and use source rather than the gem.
# 
# From the /lib/ directory:  ruby run.rb
# 
path = File.dirname( File.absolute_path( __FILE__ ) )
root = File.join( path, "outline_script", "**/*.rb" )
Dir.glob( root ) { |ruby_file| require ruby_file }

OutlineScript::App::Engine.new.start