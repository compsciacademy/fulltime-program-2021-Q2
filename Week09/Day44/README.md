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

Let's generate a model to go along with our articles. When we generate controllers, we use a plural name `Articles`, and when we generate a model, we use a singular name `Article`.  
  
```
bin/rails generate model Article title:string body:text
```

This generator will create a couple of files for us, noteably, a model generator creates a _migration_ file. Run this migration to make the appropriate changes to the database.  
  
```
bin/rails db:migrate
```  

There should be some output to show that the migration successfully created a table `:articles`.   
  
---   

Load up rails console and let's see if we can create some articles.... 

```
bin/rails console
```

This automatically loads our app, so we have access to the same sorts of methods on models as we did when we were using irb and loading our sinatra app with mongoid.  
  
```
article = Article.new(title: 'My Title', body: 'My Article Body')
article.save

article = Article.new(title: 'My Other Title', body: 'My Other Article Body')
article.save

Article.all
```  
  
Update the article index view and controller to display a list of all article titles.  
  
```html
<h1>Articles</h1>

<ul>
  <% @articles.each do |article| %>
    <li><%= article.title %>
  <% end %>
</ul>

```

```ruby
class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
end
```

That was pretty easy! Rails sure does things as you might expect. Now, let's add in a way to view a single article. Following the order we used last time, let's start with a route, then a controller, and a view...   
   
... and then full crud, with a form partial and the use of some nice helper methods.  
  
And may as well add another resource for comments!  
  
```
bin/rails generate model Comment commenter:string body:text article:references
```

This adds a `article_id` field on comments. You can also see in the comment model, the line, `belongs_to :article`.  
  
You will have to manually edit the article model to add the line: `has_many :comments`. This will give you some nice methods, such as `comment = Article.last.comments.new`  
  
Generate a comments controller  
```
bin/rails generate controller Comments
```

We want to be able to create comments on articles, so it probably makes sense to add a comment form on the article show view.  
  


