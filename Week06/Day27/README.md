# Day 27  
  
Sinatra is pretty cool, but it could do a little more for us than it currently does.  

Let's say I wanted to create some sort of application, and I wanted to add some resources that I would be able to perform CRUD operations on. Rather than manually typing out each class name, the instance methods for setters and getters, the route controllers in the app's entrypoint, etc. wouldn't it be nice if we could just type some command line commands, instead?  

## Exercise 01: CLI MyNatra  

Write a command-line interface that takes some commands and arguments and produces an application that is arranged in a way that we would like it to be.  

E.g.
```
mynatra new MyBlog
```
This should create a directory called `MyBlog`. Inside the directory there should be a basic Sinatra app with the default configurations that you like. If you have different configuration options you'd like to set on initialization, you can do so.

Perhaps something like this (consider this an optional stretch goal):
```
mynatra new MyBlog --set public_folder: lolface
```

With your application, you may wish to add some _resources_, such as let's say a user:
```
mynatra resource user email password
```
This should create a user class with getters and setters for email and password. It should also create CRUD routes in the application's `app.rb` for users, as well as the appropriate views to perform such CRUD operations.

**Part 1**  

How you decide to structure your application is up to you! For example, you may wish to call your `app.rb` something else. You may wish to have resources in a particular directory, or directories. You may wish to put all the files in the same directory.  

Before you begin building out the CLI to automate the creation of resources, put some thought and work into how you'd like files and directories to be structured.    
  
It's probably a good idea to manually create something first, and then work on automating its creation.  
  
---
## Getting started with Exercise 1  
  
The initial setup for a MyNatra application can be quite simple. It could be as simple as creating a directory and a single file inside it.  
  
Running the command `mynatra new MyBlog` could create a directory called `MyBlog/` with a file inside called `app.rb`  
  
```ruby
# MyBlog/app.rb
require 'sinatra'  
```

And that could be it!  
  
Of course, if we want our development framework to include things that we pretty much know we are going to use to get started, indeed saving time on later projects is a big reason to automate the initial setup this way, then what would be a more robust starting point?  
  
In this case, we might consider adding a Gemfile, some views with styles and scripts in place for us to just start coding.  
  
```
MyBlog/
|
---app.rb
|
---views/
|     |
|     ---footer.erb
|     ---getting_started.erb
|     ---header.erb
|     |
---public/
|     |
|     ---scripts/
|     |     |
|     |     ---main.js
|     ---styles/
|     |     |
|     |     ---main.css
|     |     |
---gemfile

```
