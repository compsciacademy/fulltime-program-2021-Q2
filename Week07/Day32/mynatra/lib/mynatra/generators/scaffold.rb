require 'thor/group'

module MyNatra
  module Generators
    class Scaffold < Thor::Group
      include Thor::Actions
      argument :project, type: :string

      # creates an empty directory with the name of the given
      # argument 'project'
      def create_project
        empty_directory(project)
      end
    end
  end
end
