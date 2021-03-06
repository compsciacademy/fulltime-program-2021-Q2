# Day 51  
  
## Polymorphic Assocations  
   
Today, we're going to talk about [polymorphic associations](https://en.wikipedia.org/wiki/Polymorphic_association). Here are some relevant links:  
  
[Single Table Inheritance](https://en.wikipedia.org/wiki/Single_Table_Inheritance) | [Active Record Associations](https://guides.rubyonrails.org/association_basics.html#polymorphic-associations) | [RailsCast](http://railscasts.com/episodes/154-polymorphic-association)    
  
## Single Table Inheritance  
  
"_Single table inheritance is a way to emulate object-oriented inheritance in a relational database. Polymorphic association is a term used in discussions of Object-Relational Mapping with respect to the problem of representing in the relational database domain, a relationship from one class to multiple classes._" - [wikipedia](https://en.wikipedia.org/wiki/Single_Table_Inheritance)  
  
"_Relational databases don't support inheritance, so when mapping from objects to databases we have to consider how to represent our nice inheritance struc-tures in relational tables. When mapping to a relational database, we try to minimize the joins that can quickly mount up when processing an inheritance structure in multiple tables. Single Table Inheritance maps all fields of all classes of an inheritance structure into a single table._" - [Martin Fowler](https://www.martinfowler.com/eaaCatalog/singleTableInheritance.html)  
  
Create a new Rails app, and generate a user model: 

```
rails new test_sti -T -J 

```

Create a new model for Moderator and Admin, both of which inherit from User. However, we'll create them in a separate folder in the models folder. Rails will treat this as a module, and we'll be able to access these models using the double colon style: `User::Moderator`  
  
```ruby
# app/models/user/moderator.rb
class Moderator < User
  validates :first_name, :last_name, presence: true
end
```

```ruby
# app/models/user/admin.rb
class Admin < User
end
```

and of course, we need a User model `rails generate model User first_name last_name email`
```ruby
class User < ApplicationModel
  validates :email, presence: true
end
```

Run db migrations to set up the database and add users. Then hop into the rails console to see what we can do:

```
bin/rails db:migrate
bin/rails console
```

Now we can see that we can access `User`, `Moderator`, and `Admin` with the same interface methods, but the validations are different. All the children inherit from the parent, i.e. `Moderator` and `Admin` require an email before they can be saved, whereas `User` and `Admin` do not require `first_name` or `last_name`.  
  
```ruby
u = User.new
u.save
> false
u.email = 'drew@example.com'
u.save
> true

m = Moderator.new
m.email = 'mod@example.com'
m.save
> false
m.first_name = 'modperson'
m.last_name = 'lastname'
m.save
> true
```

All three classes use the same table in the database. This is a pretty simple version of STI, but it exemplifies a use case and how it can work.  
  
## Polymorphic Associations  
  
Let's generate some resources, say discussions and comments:  
  
```
bin/rails generate resource discussion title:string body:text user:references
bin/rails generate resource comment body:text commentable:references
```

Then open up the comments migration file and set `polymorphic: true`

```ruby
class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :commentable, null: false, polymorphic: true

      t.timestamps
    end
  end
end
```

Another way we could do this, would be:
```ruby
class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.bigint :commentable_id
      t.string :commentable_type

      t.timestamps
    end

    add_index :comments, [:commentable_id, :commentable_type]
  end
end
```

Run `bin/rails db:migrate` and add some commentable and comment associations to the comment, user, and discussion models.

```ruby
# app/models/user.rb
class User < ApplicationRecord
  validates :email, presence: true
  has_many :discussions
  has_many :comments, as: :commentable
end
```

```ruby
# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
end
```

```ruby
class Discussion < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
end
```

We also needed to add `has_many :discussions` to the `User` model.  
  
Now, we can open up `bin/rails console` and create some discussions and comments... 

```ruby
user = User.last
discussion = user.discussions.create(title: "This is a Wonderful Title!", body: "What an amazing body this discussion has. Have you ever thought about bread?")

discussion.comments.create(body: 'I have thought about bread. Have you thought about dough, though?')

discussion.comments.create(body: 'What about dough?')
```

## Consider the Views  
  
Update the routes, nesting comments resources in discussions
```ruby
Rails.application.routes.draw do
  root to: "discussions#index"
  
  resources :discussions do
    resources :comments
  end
end

```

Add an index view for Discussions, and show view for individual discussions, with accompanying controllers

```ruby
class DiscussionsController < ApplicationController
  def index
    @discussions = Discussion.all
  end

  def show
    @discussion = Discussion.find(params[:id])
  end
end

```

And the index and show views
  
index.html.erb
```html
<h1>All Discussions</h1>

<ul>
  <% @discussions.each do |discussion| %>
    <li><%= discussion.title %> <%= link_to "show", discussion_path(discussion) %></li>
  <% end %>
</ul>

```
  
show.html.erb
```html
<h1><%= @discussion.title %></h1>

<p><%= @discussion.body %>

<h2>Comments</h2>

<ul>
  <% @discussion.comments.each do |comment| %>
    <li><%= comment.body %></li>
  <% end %>
</ul>

```

Now that we are able to view discussions and comments, we want a way to add (and maybe delete) a comment.
  
Add a form for creating comments to the Discussions show view

```html

<%= form_for [@discussion, @discussion.comments.new] do |f| %>
  <%= f.text_area :body %>
  <br>
  <%= f.submit %>
<% end %>

```

And a create action in the comments controller

```ruby
class CommentsController < ApplicationController
  def create
    @discussion = Discussion.find(params[:discussion_id])
    @comment = @discussion.comments.new(comment_params)
    if @comment.save
      redirect_to @discussion, notice: "Comment Created"
    else
      render discussion_path(@discussion)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end

```

We can add a validation on the Comment model that ensures it has a `:body` attribute.

```ruby
class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  validates :body, presence: true
end

```

Now, we have a couple of things to do. We'd like to add a Project resource, that Discussions belong to, and also make them commentable, i.e. projects can have many comments.  
  
Another thing we'd like to do is add user authentication, using Devise to our existing User model. Then we can add something like `before_action :authenticate_user!` to our comments controller.  
  
And another thing is that we'd like some better styling for our application, so we can add Bootstrap and some classes that make things look pretty.  
  
## Exercise 01
  
Add Projects to the application. Projects have many discussions, and discussion belong to a project. Projects should have a project title.  
  
Additionally, projects are commentable. This means, we'll be able to make comments on projects, and we will want to be able to determine, in the comments controller whether a comment's `commentable_type` is for a project or a discussion. We can do that by looking for either a `project_id` or a `discussion_id` in the params.  
  
```ruby
if params[:project_id]
  # do something
elsif params[:discussion_id]
  # do something else
end
```

## Exercise 02

Add [Bootstrap](https://getbootstrap.com/) to the application with appropriate classes for styling. Additionally, add a navigation menu.  
  
## Exercise 03  
  
Add authentication to the existing User model using [Devise](https://github.com/heartcombo/devise/wiki/How-To:-Change-an-already-existing-table-to-add-devise-required-columns). Also, make sure that a user is logged in before being able to create, modify or destroy any resources.  
  
