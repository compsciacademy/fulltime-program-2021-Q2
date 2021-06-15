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

Start MongoDB if you need to, pointing to [the configuration](https://docs.mongodb.com/manual/reference/configuration-options/): 

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

Let's start with that, and see if we can actually create some cars using IRB.  

```ruby
? irb
> load './car_list.rb'
> Car.create(brand: 'Ford', model: 'Mustang', color: 'Grabber Blue', year: 1968)

```

If all goes well, we're up and running!
  
Next, we can add a namespace (using the `sinatra-contrib` gem), if we want, and add CRUD endpoints to it...  
  
```ruby
require 'sinatra'
require 'sinatra/namespace'
require 'mongoid'

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

namespace '/api' do
  # set the content type for all endpoints
  before do
    content_type 'application/json'
  end

  get '/cars' do
    Car.all.map { |car| Serializer.new(car) }.to_json
  end
end

# add a serializer 
class Serializer
  def initialize(car)
    @car = car
  end

  def as_json(*)
    fields = {
      id: @car.id.to_s,
      brand: @car.brand,
      model: @car.model,
      color: @car.color,
      year: @car.year
    }
    fields[:errors] = @car.errors if @car.errors.any?
    fields
  end
end
```

**HINT**: Checkout the codebase to see how we rewrote this!  
  
---

How about if we want to _create_ new Cars... well, let's define an endpoint that handles POST requests to _create_ new cars...  
  
```ruby
# ...

post '/cars' do
  request_body = request.body.read
  begin
    new_car_params = JSON.parse(request_body)
  rescue
    halt 400, { message: "bad JSON, yo!" }.to_json
  end

  car = Car.new(new_car_params)

  if car.save
    # happy path
    # send 201 status code
    # and Location: /api/cars/car.id
    response.headers['Location'] = "/api/cars/#{car.id}"
    status 201
  else
    # could not process the request
    # send 422 unprocessable entity 
    # body new_car_params.to_json
    status 422
    body new_car_params.to_json
  end
end

# ...


```