# Day 31  

## Exercise 01    
  
Refine the MyNatra application such that the following works.  

```
mynatra new MyBlog && cd MyBlog
mynatra resource post title body
mynatra resource comment body
```

The first command, `mynatra new MyBlog && cd MyBlog` is really 2 parts.

`mynatra new MyBlog` should create a directory `MyBlog/` with the base scaffolding for a mynatra project.

```
MyBlog/
  |-app.rb
  |
  |-views/
    |
    |-footer.erb
    |-getting_started.erb
    |-header.erb
  |
  |-public/
    |
    |-scripts/
      |
      |-main.js
    |-styles/
      |
      |-main.css
  |
  |-gemfile

```
the second part `&& cd MyBlog` just changes the working directory, so that subsequent commands are run from within the `MyBlog` project that was just set up.  
  
`mynatra resource post title body` should create a resource called `post` that has attributes `title` and `body`. This should have all supporting files to be able to perform CRUD operations. This includes a model, controllers, and views.  
  
`mynatra resource comment body` should also create a resource called `comment` that has an attribute `body`. This should have all supporting files to be able to perform CRUD operations. This too includes a model, controllers, and views. 

This should result in something like the following:  

```
MyBlog/
  |-app.rb
  |-controllers/
    |-comments_controller.rb
    |-posts_controller.rb
  |-models/
    |-comment.rb
    |-post.rb
  |-views/
    |-comments/
      |-edit.erb
      |-index.erb
      |-new.erb
    |-footer.erb
    |-getting_started.erb
    |-header.erb
    |-posts/
      |-edit.erb
      |-index.erb
      |-new.erb
  |-public/
    |-scripts/
      |-main.js
    |-styles/
      |-main.css
  |-gemfile
```
