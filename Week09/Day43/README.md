# Day 43  
  
## Quiz Time!  
  
**Option A**  

Create an application that allows you to create TODO lists. The index view should show a list of TODO lists, maybe with a maximum of 10 lists shown at a time (you can use pagination).  

Showing a list should give the option to add an item, remove an item, mark an item as done (unmark an item as being done).  
  
**Option B**  
  
Create an application that allows you to create a list of your favorite links. Each link should have a title, and a description. You should also be able to upvote and downvote links.  
  
The index view should allow you to see all the lists, maybe with a maximum of 5 or 10 at a time (you can use pagination). It would be great to also have the ability to see the top 3 upvoted links.
  
---

## A Sinatra Blog with Comments  
  
Create a directory for our blog project, let's call it `blog`. Add a Mongo Config file, and an `app.rb` or `blog.rb`  
  
```
mkdir blog
cd blog
touch blog.rb
touch mongoid_config.yml

```

`mongoid_config.yml`
```yml
development:
  clients:
    default: blog_development
    database: blog
    hosts:
     - localhost:27017
```

And add a gemfile
```ruby
source 'https://rubygems.org'

gem 'sinatra'
gem 'mongoid'
gem 'thin'

```

`blog.rb`
```ruby
require 'sinatra'
require 'mongoid'

######################
#  Models
######################
class Post
  include Mongoid::Document

  field :title
  field :body

  has_many :comments
end

class Comment
  include Mongoid::Document

  field :name
  field :message

  belongs_to :post
end

######################
#  Routes
######################

get '/posts' do
  Post.all.to_json
end

post '/posts' do
  post = Post.create(params[:post])
  post.to_json
end

get '/posts/:id' do |id|
  post = Post.find(id)
  post.attributes.merge(
    comments: post.comments
  ).to_json
end

post '/posts/:post_id/comments' do |post_id|
  post = Post.find(post_id)
  comment = post.comments.create(params[:comment])
  {}.to_json
end

```

`bundle exec ruby blog.rb` to run the blog, and then use curl (or Postman, or some frontend) to hit the API  
  
```sh
# get all posts
curl http://localhost:4567/posts

# create a post
curl -X POST -d 'post[title]=My+New+Blog+Post&post[body]The+body+of+my+blog+post.' http://localhost:4567/posts

# add a comment to the post
# NOTE: use the post id
curl -X POST -d 'comment[name]=Drew&comment[message]=Nice+post' http://localhost:4567/posts/60d3b3d84bd63c0bbdd50d21/comments

# Get a post by post id
curl http://localhost:4567/posts/60d3b3d84bd63c0bbdd50d21
```

Now, you can use `has_many` and `belongs_to` yourself!  
  
This should be helpful for your quiz :D
