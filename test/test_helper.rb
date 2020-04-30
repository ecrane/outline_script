$LOAD_PATH.unshift File.expand_path('../../lib', __dir__)

require 'minitest/autorun'

# Require all ruby source files
path = File.dirname( File.dirname( File.absolute_path( __FILE__ ) ) )
root = File.join( path, 'lib', 'gloo', '**/*.rb' )
Dir.glob( root ) { |ruby_file| require ruby_file }
