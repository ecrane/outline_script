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
