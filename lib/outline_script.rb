require 'outline_script/app/engine'

module OutlineScript  
  self.run
    OutlineScript::App::Engine.new.run
  end
end