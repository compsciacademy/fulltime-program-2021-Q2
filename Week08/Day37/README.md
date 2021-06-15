# Day 37  
  
Last time, we talked about a books api. Let's revisit, and continue with the same concept, but a different theme. A Cars API...  
  
Remember from yesterday that if we're going to use mongoid with a MongoDB backing store, we can just add a couple of lines to our application, and a configuration file, and we get a bunch of methods _out of the box_ so to speak.  
  
This is partially because of mongoid's ActiveModel depdency.  
  
Have a look at [mongoid's configuration documentation](https://docs.mongodb.com/mongoid/current/tutorials/mongoid-configuration/), and let's get a config file!  

```yml
development:
  clients:
    default:
      database: CarList
      hosts:
        - localhost:27017

```

And create an `app.rb` or `car_server.rb` or whatever you'd like to name it. It could even be `api.rb`, all of which would be somewhat descriptive. We'll use `car_list.rb` today...  
  
```ruby
# car_list.rb
require 'sinatra'
require 'mongoid'

# db config
Mongoid.load! 'mongoid_config.yml'

class Car

end

```

We can add `include Mongoid::Document` to the class to make it a Model, in the Model Document Mapper sense of the word. This gives us access to [mongoid methods](https://docs.mongodb.com/mongoid/current/tutorials/mongoid-documents/) such as [fields](https://docs.mongodb.com/mongoid/current/tutorials/mongoid-documents/#fields).  
  
According to the documentation, when you specify a field, you can ommit its type, and Mongoid will treat it as an object. This might not always work, but you can safely omit types when:

  - You’re not using a web front end and values are already properly cast.
  - All of your fields are strings.

So, let's go ahead and define the fields for our Car model.

```diff
# car_list.rb
require 'sinatra'
require 'mongoid'

# db config
Mongoid.load! 'mongoid_config.yml'

class Car
+  include Mongoid::Document
+
+  field :brand
+  field :model
+  field :options, type: Hash
end

```

```ruby
# car_list.rb
require 'sinatra'
require 'mongoid'

# db config
Mongoid.load! 'mongoid_config.yml'

class Car
  include Mongoid::Document

  field :brand
  field :model
  field :color
  field :year, type: Integer

  validates :brand, :model, :color, presence: true
  validates :year, numericality: { only_integer: true }, length: { is: 4 }
end
```

Let's start with that, and see if we can actually create some cars using IRB.