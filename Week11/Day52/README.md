# Day 52

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
  
