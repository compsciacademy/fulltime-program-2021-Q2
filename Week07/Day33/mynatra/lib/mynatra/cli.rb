require 'thor'
require 'mynatra/generators/scaffold'
require 'mynatra/generators/resource'

module MyNatra
  class CLI < Thor
    desc "new [PROJECT]", "Creates a new directory with MyNatra project scaffolding"
    def new(project)
      MyNatra::Generators::Scaffold.start([project])
    end

    desc "resource [NAME] [<ATTRIBUTES>]", "Creates a resource of the given name with optional attributes"
    def resource(name, *attributes)
      MyNatra::Generators::Resource.start([name, attributes])
    end
  end
end
