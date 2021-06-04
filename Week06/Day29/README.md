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

## Adding other gems  
  
There's a method called `pluralize` that can take a word and give its plural. This method is part of a gem called `activesupport`. Let's require that in our gem specification.  
  
```ruby
# ...

spec.add_dependency "activesupport"

# ...
```

Now, a `bundle install` should add the new dependcy `activesupport` to our bundle. With `activesupport` installed, let's make use of it by adding a `pluralize` method to `Foodie::Food`. But, before we do, let's spec it out:  
  
```ruby
it "pluralizes a word" do
  expect(Foodie::Food.pluralize("Tomato")).to eql("Tomatoes")
end

```

Running `bundle exec rpsec spec` will fail, since there is no `pluralize` method defined on `Foodie::Food`. Now that we have a failing spec, let's make it pass!  

```ruby
# lib/foodie/food.rb
require 'active_support/inflector'

module Foodie
  class Food
    def self.portray(food); end

    def self.pluralize(word)
      word.pluralize
    end
  end
end

```

## Add a CLI  

Define a CLI in `lib/foodie/cli.rb`:  
  
```ruby
require 'thor'
module Foodie
  class CLI < Thor

  end
end

```

Add the dependency to your gemspec

```ruby
# foodie.gemspec.rb

# ...

spec.add_dependency "thor"

# ...

```

Before developing out our CLI, let's make sure we are ready to test it, as we go. BDD (Behavior Driven Development) is an interesting testing methodology. There are some tools we can use to _test it out_, such as the gem Cucumber! Let's do that.

We are using RSpec for testing the main application logic in our gem, and now adding Cucumber for testing the CLI. THere's another tool that is useful for testing that works well with both of those. It's called... Aruba.
```ruby
spec.add_development_dependency "cucumber"
spec.add_development_dependency "aruba"

```

Run `bundle install` to install the dependencies, and then let's add some feature tests to `features/food.feature'

```yaml
Feature: Food
  In order to portray or pluralize food
  As a CLI
  I want to be as objective as possible

  Scenario: Broccoli is gross
    When I run `foodie portray broccoli`
    Then the output should contain "Gross!"

  Scenario: Tomato, or Hakuna Matada?
    When I run `foodie pluralize --word Tomato`
    Then the output should contain "Tomatoes"

```

Now we want to have our Foodie gem's CLI actually execute some commands when we call `foodie <command>`. To do so, let's add an executable script.  
  
```sh
#!/usr/bin/env ruby

puts "LoLFACE!!!!"

```

Create an exe directory in the foodie gem root directory, and add this script simply named `foodie` to it and run `chmod +x exe/foodie` to make sure it is executable:

```ruby
#!/usr/bin/env ruby
require 'foodie/cli'

Foodie::CLI.start
```

Let's define some Thor Tasks inside the Foodie::CLI

```ruby

require 'thor'
require 'foodie'

module Foodie
  class CLI < Thor
    desc "portray [FOOD]", "Determines where a food item is gross or delicious"
    def portray(food)
      puts Foodie::Food.portray(food)
    end

    desc "pluralize -w/--word [WORD]", "Pluralizes a word"
    method_option :word, aliases: "-w"
    def pluralize
      puts Foodie::Food.pluralize(options[:word])
    end
  end
end

```

Now, you should be able to run commands like:
```
bundle exec exe/foodie portray broccoli
bundle exec exe/foodie pluralize tomato
```

Make sure the cucumber feature tests work
```
bundle exec cucumber features
```
And it's all green!  
  
