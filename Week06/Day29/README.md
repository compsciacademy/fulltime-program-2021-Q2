# Day 29  

## Using Bundler to Create a Gem  

In Ruby, we call a library of code, a _gem_. In some languages, similar things are called libraries, modules, or packages.  
  
It might make sense in Ruby to call a _gem_ a module, since we typically use the `module` keyword when creating them. However, we refer to these modules or generically speaking, code libraries as _gems_.  
  
Bundler is a tool that we use in Ruby for dependency management, i.e. `bundle install` will read the Gemfile of a project and install its dependencies for you. We can also use it for creating our own gems.  

Check the version of bundler that you have:  
```
bundle -v
```

Let's create a gem of our own. This gem is going to do a couple of things. We can call it foodie, and it can give us information about various foods, for example whether the food is delicious or gross.  

To create a gem (and in this case a gem called foodie), we are going to run the following command:
```
bundle gem foodie
```
This creates a directory _foodie_ with a Gemfile, and other supporting files that are the scafolding for our gem. `cd` into the newly created directory and run `rake -T` to see what rake tasks are available.  

```
cd foodie && rake -T
rake build            # Build foodie-0.1.0.gem into the p...  
rake clean            # Remove any temporary products
rake clobber          # Remove any generated files
rake install          # Build and install foodie-0.1.0.ge...  
rake install:local    # Build and install foodie-0.1.0.ge...  
rake release[remote]  # Create tag v0.1.0 and build and p... 
```

## Testing with RSpec

Let's take a look at a testing library called RSpec, which is very popular in the Ruby community, and let's include it in our gem.  
  
Start off by creating a `spec/` directory in the root of our project. And add rspec as a _development_ dependency to the `foodie.gemspec`

```ruby
# ...

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_development_dependency "rspec"

# ...
```

Now if we run `bundle install`, we should be able to resolve our dependencies.

Let's add a new file `spec/foodie_spec.rb` and add some specs!  
```ruby
describe Foodie::Food do
    it "broccoli is gross" do
        expect(Foodie::Food.portray("Broccoli")).to eql("Gross!")
    end

    it "anything else is delicious" do
        expect(Foodie::Food.portral("Not Broccoli")).to eql("Delicious!")
    end
end

```

Now, let's run the specs using `bundle exec` 
```
bundle exec rspec spec
```

Since we don't have `Foodie::Food`, rspec complains:

```
NameError:
  uninitialized constant Foodie::Food
```
So, let's add it in `lib/foodie/food.rb`

```ruby
module Foodie
  class Food
    def self.portray(food)
      if food.downcase == "broccoli"
        "Gross!"
      else
        "Delicious!"
      end
    end
  end
end
```

We should require this file in our `lib/foodie.rb' which is the main entrypoint into our gem.  
  
Also, the spec should require `foodie` in order to be able to load the class we just added.


```ruby
# lib/foodie.rb
# frozen_string_literal: true

require_relative "foodie/version"
require "foodie/food"

module Foodie
  class Error < StandardError; end
  # Your code goes here...
end

```

```ruby
# spec/foodie_spec.rb
require 'foodie'

describe Foodie::Food do
    it "broccoli is gross" do
        expect(Foodie::Food.portray("Broccoli")).to eq("Gross!")
    end

    it "anything else is delicious" do
        expect(Foodie::Food.portray("Not Broccoli")).to eq("Delicious!")
    end
end
```
