require 'thor/group'
require 'active_support/inflector'

module MyNatra
  module Generators
    class Resource < Thor::Group
      include Thor::Actions
      MyNatra::Generators::Resource.source_root(File.dirname(__FILE__))
      argument :name, type: :string
      argument :attributes, type: :array

      # We need to build out the models, views, and controllers for
      # the resource.

      # pass in name and attributes to the model template
      # and put it in the models directory
      def create_models
        @name = name.singularize.downcase
        @name_plural = @name.pluralize
        @attributes = attributes
        template("./templates/model.erb", "./models/#{name}.rb")
      end

      def create_controllers
        @name = name.singularize.downcase
        @name_plural = @name.pluralize
        @attributes = attributes
        template("./templates/controller.erb", "./controllers/#{name.pluralize}_controller.rb")
      end

      def create_views
        # @name = name.singularize.downcase
        # @name_plural = @name.pluralize
        # @attributes = attributes
      end
    end
  end
end
