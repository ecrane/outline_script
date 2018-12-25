require "outline_script/version"
require 'active_support/inflector'

module OutlineScript

  def self.hw
    puts "Hello World."
  end

  def self.pluralize( word )
    return word.pluralize
  end
  
end
