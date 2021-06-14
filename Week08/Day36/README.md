# Day 36  
  
Today, let's build out an application that uses Sinatra to build a web API, with some API endpoints that we can use as a server to populate data on a front-end client. 

Let's make a list of books for example, and serve them through our API... 

```
mkdir MyBooks
cd MyBooks && touch server.rb
```

```ruby
# server.rb

require 'sinatra'

get '/' do
  '<h1>Book List</h1>'
end

```

MongoDB  
  * [Install MongoDB for WSL](https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-database#install-mongodb)

There are several different DBMS tools we can work with. Today, let's have a look at [MongoDB](https://docs.mongodb.com/manual/installation/). After you've installed the appropriate MongoDB for your system, install the [Mongoid gem].  

```
gem install mongoid
```

Mongoid is an ODM (Object-Document Mapper) framework for MongoDB in Ruby. What that means is that it provides and interface to map a Ruby _object_ to a MongoDB _[document](https://docs.mongodb.com/manual/core/document/)_.  
  
_"MongoDB stores data records as BSON documents. BSON is a binary representation of JSON documents, though it contains more data types than JSON."_

[JSON](https://www.json.org/json-en.html), which stand for JavaScript Object Notation is a way to organize data that is reasonably easy to work with for computers as it maps to JavaScript objects, and reasonably easy to read for humans...
  
BSON is a _Binary representation_ of JSON. Which is a better storage format.  
  
Let's think through a conceptual model of what Mongoid does for us...

e.g. 

```ruby
class Book
  attr_accessor :title, :author, :isbn
  def initialize(title, author, isbn)
    @title, @author, @isbn = title, author, isbn
  end
end

book = Book.new("The Selfish Gene", "Richard Dawkins", "9780192860927")
```

How would we represent that `book` _object_ as JSON?  
  
Well, assuming we do not add any additional information, such as ID, or other meta data that may be used by the database management system to index, etc. then it might look something like this:  

```json
{
 "title": "The Selfish Gene",
 "author": "Richard Dawkins",
 "isbn": "9780192860927"
}

```
With that said, it isn't too difficult to imagine what sort of functionality is baked into mongoid.  
  
From the documentation, [Mongoid Configuration](https://docs.mongodb.com/mongoid/current/tutorials/mongoid-configuration/):  
  
_"Mongoid is customarily configured through a mongoid.yml file that specifies options and clients. The simplest configuration is as follows, which configures Mongoid to talk to a MongoDB server at “localhost:27017” and use the database named “mongoid”._  
  
```yml
development:
  clients:
    default:
      database: mongoid
      hosts:
        - localhost:27017
```

Let's add our `configuration.yml` with a database that is specific to our book list application:
```yml
development:
  clients:
    default:
      database: booklist_dev
      hosts:
        - localhost:27017
```

Update the `server.rb` to require `mongoid` and load the config.  
  
```ruby
# server.rb
require 'sinatra'
require 'mongoid'

# load mongoid config
Mongoid.load! 'mongoid_config.yml'

# ...
```  

When using Mongoid, we can add `include Mongoid::Document` to the Ruby class definitions. This allows us to define `[fields](https://mongoid.github.io/old/en/mongoid/docs/documents.html#fields)` and their types.  
  
```ruby
# server

# ...

class Book
  include Mongoid::Document

  field :title, type: String
  field :author, type: String
  field :isbn, type: String

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true
  # validates_presence_of :isbn

end

```

the `validates` function is pretty self-explanatory. Mongoid uses [ActiveModel Validations](https://www.rubydoc.info/gems/activemodel/ActiveModel/Validations).  
  
We can use mongoid's `create_indexes` rake task to create the indexes for our models...   
  
Make sure to start the mongo process, pointing to [the configuration](https://docs.mongodb.com/manual/reference/configuration-options/): 

WSL
```
sudo service mongodb start
```

Linux
```
mongod --config /etc/mongod.conf
```

macOS
```
# intel processor
mongod --config /usr/local/etc/mongod.conf 

# M1 processor
mongod --config /opt/homebrew/etc/mongod.conf
```

Start `irb` load up the `server.rb`, then `create_indexes` and create a book entry.  
  
```
irb
load "./server.rb"
Book.create_indexes
Book.create(title: 'The Selfish Gene', author: 'Richard Dawkins', isbn: '9780192860927')
```

If all go well, then great!  
  
Let's add a gemfile to help manage our dependencies... 
  
```ruby
# Gemfile
source 'https://rubygems.org'

gem 'sinatra'
gem 'puma'
gem 'mongoid'
```

Then we can run `bundle install` to have everything ready for our local development environment, and instead of running `ruby server.rb`, we can run `bundle exec ruby server.rb`...
  
## Using [SINATRA::NAMESPACE](http://sinatrarb.com/contrib/namespace)
  
Sinatra Namespace is part of the Sinatra Contrib gem, so we will `require 'sinatra/namespace' in our application, and `gem 'sinatra-contrib'` in our gemfile.  
  
```ruby
# server.rb
require 'sinatra/namespace'

# ...

```

```ruby
# Gemfile
# ...
gem 'sinatra-contrib'
# ...
```
Run `bundle install` to update the dependencies.  
  
To use namespace, we can just define it with our routes, like so:  
```ruby
# server.rb

# ...

namespace '/api/v1' do
  # return a list of all books
  get '/books' do
  end

  # create a new book
  post '/book' do
  end
end

```

So, let's add an endpoint to get all of the books. In this case, we want to define the content type in our HTTP headers to be `json` for our API. To do this, we can ad a `before` block within the namespace.  
  
```ruby


namespace '/v1' do
  before do
    content_type 'application/json'
  end

  # return a list of all books
  get '/books' do
    Book.all.to_json
  end
end

```

## Exercise 1  
  
Read the documentation for the [scope](https://guides.rubyonrails.org/active_record_querying.html) keyword in Rails, and see if you can figure out how to add a _filter_ for Books...  
  
For example, if I want find all books where a given author name is the the name of the book's author, how should it look?  
  
```ruby
scope :by_author, ->(author_name) { where(author: author_name) }
```

Let's call this scope (filter) if `params[:author]` is a url parameter: 

```ruby
# server.rb

# ...

  get '/books' do
    books = Book.all

    if params[:author]
      books = books.send(:by_author, params[:author])
    end

    books.to_json
  end

# ...

```

So, what if we want to _create_ a new book through an API endpoint?  
  
Well, of course we can add a post request, and a way to handle it. We already have a pretty good idea about what that endpoint will look like, so how will we use mongoid to process the request and store a book object?  
  
```ruby
# server.rb
# ...
namespace '/v1' do
# ...

  post '/books' do
    # instatiate a new book
    # we can use Book.new --- but how?
    #
    # we can use .save on the instantiated object... but how?
    #
    # we also want to send a response... but how?
  end

# ...
end
# ...

```

We can do `Book.create()` which will take parameters for a book object and try to save that to the database. This is like doing the following:
```ruby
Book.create(title: 'The Selfish Gene', author: 'Richard Dawkins', isbn: '9780192860927')

# is equivalent to 
book = Book.new(title: 'The Selfish Gene', author: 'Richard Dawkins', isbn: '9780192860927')
book.save

# the difference here being that we have a chance to do something with `book` before we call save, if we want to.
```

```ruby
# server.rb
# ...
namespace '/v1' do
# ...

  post '/books' do
    book_params = JSON.parse(request.body.read)
    puts book_params
  end

# ...
end
# ...

```

## Exercise 2

Keeping in mind that we can call `Book.create` directory or `Book.new` to instantiate a new book object, then perform some actions, if we'd like to, on that object....

See if you can finish up the `post '/books' do; end` route handler.  
