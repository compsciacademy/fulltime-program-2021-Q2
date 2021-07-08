# Day 52

## Exercise 01 - Review
  
Add Projects to the application. Projects have many discussions, and discussion belong to a project. Projects should have a project title. 
  
Additionally, projects are commentable. This means, we'll be able to make comments on projects, and we will want to be able to determine, in the comments controller whether a comment's `commentable_type` is for a project or a discussion. We can do that by looking for either a `project_id` or a `discussion_id` in the params.  
  
```ruby
if params[:project_id]
  # do something
elsif params[:discussion_id]
  # do something else
end
```

---

Generate a model: 

```
bin/rails generate model Project title:string user:references
```

Update the model:
```ruby
class Project < ApplicationRecord
  belongs_to :user
  has_many :discussions
end

```

Update the User model to have many projects:

```ruby
class User < ApplicationRecord
  validates :email, presence: true
  has_many :comments, as: :commentable
  has_many :discussions
  has_many :projects
end
```

Run the migration with `bin/rails db:migrate`. And make sure things are as expected by testing the relations through the rails console.

```ruby
user = User.last
project = user.projects.new(title: 'My First Project')
project.save

# throws an error, "unknown attribute 'project_id' for Discussion."
project.discussions.create(title: "My first project discussion", body: "What is this project about anyway?")
```

We want to ensure that a project has many discussions and a discussion belongs to a project. So, we want to add a migration to discussions that adds project references, i.e. a `project_id`

```
bin/rails generate migration AddProjectRefToDiscussions project:references
```

This migration may fail, if you have existing discussions that do not have a `project_id` when the migration specifies `null: false`. We could remove that specification, or give a default value, or remove the existing discussions for the database to resolve that.  
  
In our case, since we're still very much in development mode, we decided it easiest to just drop the db `bin/rails db:drop` and then `bin/rails db:migrate`.  
  
Since we dropped the database, we need to create some records.

```ruby
user = User.create(first_name: 'Drew', last_name: 'Ogryzek', email: 'drew@compsci.academy')

project = user.projects.create(title: 'My First Project')

discussion = project.discussions.create(title: 'My First Project Discussion', body: 'What is this project about anyway?', user_id: project.user_id)

comment = discussion.comments.create(body: 'How do you like this comment?')
```

Now that we have a working backend, we want to update the frontend. This includes setting up the routes, controllers, and of course views.  
  
Let's start with just adding resources for projects and setting the root route to the projects index (note: we will revisit the routing structure to better reflect the relationship between projects and discussions in a little bit).

```ruby
Rails.application.routes.draw do
  root to: "projects#index"
  resources :projects 
  resources :discussions do
    resources :comments
  end
end
```

We now need a projects controller with an index action, and a view to support it.

```ruby
class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end
end

```

```html
<h1>All Projects</h1>

<ul>
  <% @projects.each do |project| %>
    <li><%= project.title %> <%= link_to "show", project_path(project) %>
  <% end %>
</ul>

```

Next up, let's add a _show_ view and links to it from the project index view.

```html
<h1><%= @project.title %></h1>

<ul>
  <% @project.discussions.each do |discussion| %>
    <li><%= discussion.title %> <%= link_to "show", project_discussion_path([@project, discussion]) %></li>
  <% end %>
</ul>

```

Before we can make that work, however, we are going to need to do a _bunch_ of stuff. What sort of stuff? Well, we will want to modify the routes, so that discussions are nested in projects:

```ruby
Rails.application.routes.draw do
  root to: "projects#index"
  
  resources :projects do
    resources :discussions do
      resources :comments
    end
  end
end

```

We'll need to add a show action in the projects controller:

```ruby
class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end
end
```

We will now encounter an issue with the new comments form on the discussion show view:

```html
<%= form_for [@discussion, @discussion.comments.new] do |f| %>
  <%= f.text_area :body %> 
  <br>
  <%= f.submit %> 
<% end %> 
```

We need to make 2 changes to resolve this. 1 in the show view, and 1 in the comments controller:  
  
**NOTE**: Actually 3 changes, because we forgot to add `belongs_to :project` to the discussion model
  
First, update the form to point to `project_disucussion_comments_path` by adding a project to the list of objects passed in. We could set this in the discussion controller, and pass it to the view, or we can simply get it from the discussion that we already have.

```html
<%= form_for [@discussion.project, @discussion, @discussion.comments.new] do |f| %>
  <%= f.text_area :body %> 
  <br>
  <%= f.submit %> 
<% end %> 
```

Now, update the comments controller create action to redirect to the project discussion, rather than the discussion

```ruby
redirect_to [@discussion.project, @discussion], notice: "Comment Created"
```
And change the else clause to `render project_discussion_path(@discussion)`
```ruby
class CommentsController < ApplicationController
  def create
    @discussion = Discussion.find(params[:discussion_id])
    @comment = @discussion.comments.new(comment_params)
    if @comment.save
      redirect_to [@discussion.project, @discussion], notice: "Comment Created"
    else
      render project_discussion_path([@discussion.project, @discussion])
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
end
```

## Exercise 02

Add [Bootstrap](https://getbootstrap.com/) to the application with appropriate classes for styling. Additionally, add a navigation menu.  
  
## Exercise 03  
  
Add authentication to the existing User model using [Devise](https://github.com/heartcombo/devise/wiki/How-To:-Change-an-already-existing-table-to-add-devise-required-columns). Also, make sure that a user is logged in before being able to create, modify or destroy any resources.  
  