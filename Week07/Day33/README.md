# Day 33  
  
Continuing with MyNatra, let's build out support for:

```
cd MyBlog
bundle exec exe/mynatra resource post title body
```

And make that generate the required files for performing CRUD operations on the post resource, including views, controllers, models, and whatever else we may need.  
  
We can start by adding support for the CLI interface resource command, e.g.
```ruby
# lib/mynatra/cli.rb
# ...
    desc "resource [NAME] [<ATTRIBUTES>]", "Creates a resource of the given name with optional attributes"
    def resource(name, *attributes)
      puts "Hello resource: #{name}, #{attributes}"
    end
# ...
```

And then we just need to make that do something. 

## Create Models

Let's start by adding a method to `create_models`:

```ruby
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
        @attributes = attributes
        template("./templates/model.erb", "./models/#{name}.rb")
      end

      def create_controllers; end
      def create_views; end
    end
  end
end

```

Since we're using the `singularize` method from Active Support, we need to add it to our gemspec:

```rb
# ...

  spec.add_dependency "activesupport"

# ...

```

`bundle install` and now we should be able to create a new project, cd into it, add a resource and have our models!  

And of course the `model.erb` to use as the template for our models.

```ruby
class <%= @name.capitalize %>
<% @attributes.each do |attribute| -%>
  attr_accessor :<%= attribute %>
<% end -%>

end

```
  
...  

## Create Controllers

Add a method to `create_controller` in our `MyNatra::Generators::Resource`
```ruby
      def create_controllers
        @name = name.singularize.downcase
        @name_plural = @name.pluralize
        @attributes = attributes
        template("./templates/controller.erb", "./controllers/#{name.pluralize}_controller.rb")
      end
```

And a template to support it
```python
class <%= @name_plural.capitalize %>Controller < ApplicationController
  get '/<%= @name %>/new' do
    @<%= @name %> = <%= @name.capitalize %>.new
    erb :"<%= @name %>/new"
  end
   
  post '/<%= @name %>/create' do
    <%= @name %> = <%= @name.capitalize %>.new 
  <% @attributes.each do |attribute| -%>
  <%= @name %>.<%= attribute %> = params[:<%= attribute %>]
  <% end -%> 
    <%= @name %>.save
    redirect :"<%= @name_plural %>"
  end

  post '/<%= @name_plural %>/update/:id' do
    <%= @name %> = <%= @name.capitalize %>.new 
    <%= @name %>.id = params[:id]
  <% @attributes.each do |attribute| -%>
  <%= @name %>.<%= attribute %> = params[:<%= attribute %>]
  <% end -%> 
    <%= @name %>.save
    redirect :"<%= @name_plural %>/#{<%= @name %>.id}"
  end

  get '/<%= @name_plural %>/:id' do
    @<%= @name %> = <%= @name.capitalize %>.find(params[:id].to_i)
    erb :"<%= @name_plural %>/edit"
  end

  post '/<%= @name_plural %>/delete/:id' do
    @<%= @name %> = <%= @name.capitalize %>.find(params[:id].to_i)
    @<%= @name %>.delete
    redirect :<%= @name_plural %>
  end

  get '/<%= @name_plural %>' do
    @<%= @name_plural %> = <%= @name.capitalize %>.all
    erb :"<%= @name_plural %>/index"
  end
end

```