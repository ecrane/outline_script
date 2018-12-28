require 'active_support/inflector'

module OutlineScript

  def self.run
    puts get_title
  end
  
  def self.get_title
    return "Outline Script, version #{::OutlineScript::VERSION}"
  end

  def self.pluralize( word )
    return word.pluralize
  end
  
end


#
# The following can be used to run the application in CLI mode
# in development and use source rather than the gem.
# 
# From the /lib/ directory:  ruby outline_script.rb
# 
path = File.dirname( File.absolute_path( __FILE__ ) )
root = File.join( path, "outline_script", "**/*.rb" )
Dir.glob( root ) { |ruby_file| require ruby_file }

OutlineScript.run

# grr = File.expand_path('..', __FILE__)
# puts grr
# files = Dir.chdir( grr ) do
#   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
# end
# puts files