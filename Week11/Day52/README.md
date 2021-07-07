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

## Exercise 02

Add [Bootstrap](https://getbootstrap.com/) to the application with appropriate classes for styling. Additionally, add a navigation menu.  
  
## Exercise 03  
  
Add authentication to the existing User model using [Devise](https://github.com/heartcombo/devise/wiki/How-To:-Change-an-already-existing-table-to-add-devise-required-columns). Also, make sure that a user is logged in before being able to create, modify or destroy any resources.  
  