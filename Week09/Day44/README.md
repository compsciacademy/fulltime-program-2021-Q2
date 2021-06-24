# Day 44  
  
We've worked with JavaScript for the frontend, and Ruby with some gems (libraries), such as Sinatra as a light web framework, mostly handling routes for us, and Mongoid (a mongo database driver), Thor, a CLI gem, and a handful of others.  
  
The MyNatra gem builds on top of Sinatra to add the MVC (Model-View-Controller) design pattern. There are many more features it could incorporate, depending on which direction you may wish to take it, and what your preferences are.  
  
Let's have a look at another MVC-framework, called [Ruby on Rails](https://guides.rubyonrails.org/getting_started.html).  

The Rails philosophy includes two major guiding principles:
  
  * **Don't Repeat Yourself**: DRY is a principle of software development which states that "Every piece of knowledge must have a single, unambiguous, authoritative representation within a system". By not writing the same information over and over again, our code is more maintainable, more extensible, and less buggy.
  * **Convention Over Configuration**: Rails has opinions about the best way to do many things in a web application, and defaults to this set of conventions, rather than require that you specify minutiae through endless configuration files.
  
---

Install the prerequisites as required: 
  * [Sqlite](https://www.sqlite.org/index.html)
  * [Node](https://nodejs.org/en/download/)
  * [Yarn](https://classic.yarnpkg.com/en/docs/install)
  
```
gem install rails
```

Let's make a new blog:

```
rails new blog
cd blog
```

Add a route `/articles` for the articles _index_ in `config/routes.rb`  
```ruby
Rails.application.routes.draw do
  get '/articles', to: 'articles#index'
end

```

And generate an articles controller  
```
bin/rails generate controller Articles index --skip-routes
```

If we want the root of our application to point to `/articles`, ie. when we go to `localhost:3000`, we want to see `/articles`, we can set it in our `routes.rb` like so:

```ruby
Rails.application.routes.draw do
  root 'articles#index'

  get '/articles', to: 'articles#index'
end

```
