require 'thor'
require 'mynatra/generators/scaffold'

module MyNatra
  class CLI < Thor
    desc "new [PROJECT]", "Creates a new directory with MyNatra project scaffolding"
    def new(project)
      MyNatra::Generators::Scaffold.start([project])
    end
  end
end
