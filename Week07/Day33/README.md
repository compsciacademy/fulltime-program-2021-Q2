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
  @@<%= @name_plural.capitalize %> = []
  @@count = 0
<% @attributes.each do |attribute| -%>
  attr_accessor :<%= attribute %>
<% end -%>


  def save
    if self.id.nil?
      self.id = new_id
      @@<%= @name_plural.capitalize %>.push(self)
    else
      self.id = self.id.to_i
      @@<%= @name_plural.capitalize %>.each_with_index do |<%= @name %>, index|
        if self.id == <%= name %>.id
          @@<%= @name_plural.capitalize %>[index] = self
        end
      end
    end
  end

  def delete
    @@<%= @name_plural.capitalize %>.each_with_index do |<%= @name %>, index|
      if <%= @name %>.id == self.id
        @@<%= @name_plural.capitalize %>.delete_at index
      end
    end
  end

  def self.find(id)
    @@<%= @name_plural.capitalize %>.each do |<%= @name %>|
      return <%= @name %> if <%= @name %>.id == id
    end
  end

  def self.all
    @@<%= @name_plural.capitalize %>
  end

  private

  def new_id
    @@count += 1
  end
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
  get '/<%= @name_plural %>/new' do
    @<%= @name %> = <%= @name.capitalize %>.new
    erb :"<%= @name %>/new"
  end
   
  post '/<%= @name_plural %>/create' do
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
    redirect :"<%= @name_plural %>/#{@<%= @name %>.id}"
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

## Create Views

and add an edit view template to `templates/views/edit.erb`:
```python
<%%= erb :header %>

<form method="POST" action="/<%= @name_plural %>/update/<%%= @<%= @name %>.id %>">
  <% @attributes.each do |attribute| -%>
    <p><%= attribute.capitalize %>:</p>
    <input name="<%= attribute %>" value="<%%= @<%= @name %>.<%= attribute %>%>"><br>
  <% end -%>

    <input type="submit">
</form>

<form method="POST" action="/<%= @name_plural %>/delete/<%%= @<%= @name %>.id %>">
    <input type="submit" value="Get Rid of It!!!">
</form>

<%%= erb :footer %>

```

add an index view template to `templates/views/index.erb`
```python
<%%= erb :header %>

<h1><%= @name_plural.capitalize %></h1>
<ul>
  <%% @<%= @name_plural %>.each do |<%= @name %>| %>
    <li><a href="/<%= @name_plural %>/<%%= <%= @name %>.id %>"><%%= <%= @name %>.id %></a></li>
    <ul>
  <% @attributes.each do |attribute| -%>
    <li><%%= <%= @name %>.<%= attribute%> %></li>
  <% end -%>
  </ul>
  <%% end %>
</ul>

<%%= erb :footer %>

```

And finally add a new template to `templates/views/new.erb`

```py
<%%= erb :header %>

<h1>New <%= @name.capitalize %></h1>

<form method="POST" action="/<%= @name_plural %>/create">
  <% @attributes.each do |attribute| -%>
    <p><%= attribute.capitalize %>:</p>
    <input name="<%= attribute %>" value="<%%= @<%=@name %>.<%= attribute %>%>"><br>
  <% end -%>
    <input type="submit">
</form>

<%%= erb :footer %>

```

and of course a `create_views` method to the resource generator:
```ruby
# ...
  def create_views
    @name = name.singularize.downcase
    @name_plural = @name.pluralize
    @attributes = attributes
    template("./templates/views/edit.erb", "./views/#{@name_plural}/edit.erb")
    template("./templates/views/index.erb", "./views/#{@name_plural}/index.erb")
    template("./templates/views/new.erb", "./views/#{@name_plural}/new.erb")
  end
#...

```
And that should just about do it!