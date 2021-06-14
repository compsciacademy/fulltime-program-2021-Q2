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
