# Day 30  
  
Let's continue with our gem. Last time, we looked at [gem scaffolding](https://github.com/compsciacademy/fulltime-program-2021-Q2/tree/main/Week06/Day29#using-bundler-to-create-a-gem), i.e. the setup that bundle gives us when we run the command: `bundle gem <gem name>`. We then looked at adding some functionality and [testing with Rspec](https://github.com/compsciacademy/fulltime-program-2021-Q2/tree/main/Week06/Day29#testing-with-rspec). Additionally, we [added a CLI](https://github.com/compsciacademy/fulltime-program-2021-Q2/tree/main/Week06/Day29#add-a-cli) using Thor, and tested it with Aruba and Cucumber.  
  
## Generators  
  
Let's add a generator for a _recipes_ directory. We should be able to run the generator something like this:
```
foodie recipe dinner steak
```

This should generate a `recipes/` directory (if it doesn't already exist), a `dinner/` directory inside of it (also, if it doesn't already exist), and a `steak.txt` file inside the `dinner/` directory.  
  
The `steak.txt` file should have the appropriate setup text for ingredients and the instructions for how to prepare it.  
  
Aruba has ways to test that a generator generates files and directories, so let's use that to our advantage and write some feature tests!  
  
Create a new file called `features/generator.feature`:
  
```yaml
Feature: Generating things
    In order to generate recipes
    As a CLI
    I want foodie to generate them for me

    Scenario: Recipes
        When I run `foodie recipe dinner steak`
        Then the following files should exist:
            | dinner/steak.txt |
        Then the file "dinner/steak.txt" should contain:
            """
            ##### Ingredients #####
            Ingredients for delicious steak go here.

            ##### Instructions #####
            Tips on how to make delicious steak go here.
            """

```

If we run `bundle exec cucumber features/` of course we have a failing scenario, since we do not have a task in our CLI to generate a recipe.  
  
Let's fix that now.

```ruby
# lib/foodie/cli.rb
require 'foodie/generators/recipe'

# ...

desc "recipe", "Generates a recipe scaffold"
def recipe(group, name)
    Foodie::Generators::Recipe.start([group, name])
end

# ...
```

We want to require `foodie/generators/recipe`, which is the `recipe.rb` located in `lib/foodie/generators/recipe.rb` where we will write the code that we call from the CLI `Foodie::Generators::Recipe.start([group, name])`.  
  
```ruby
# lib/generators/recipe.rb
require 'thor/group'

module Foodie
    module Generators
        class Recipe < Thor::Group
            include Thor::Actions

            argument :group, type: :string
            argument :name, type: :string
        end
    end
end
```

When we inherit from [`Thor::Group`](https://www.rubydoc.info/github/wycats/thor/Thor/Group), rather than a CLI, we are defining a _generator_. The argument method is used to define the _arguments_ for that generator.
[Thor actions](https://rubydoc.info/github/wycats/thor/master/Thor/Actions)

All of the methods within a `Thor::Group` descendant will be run when `start` is called on it. Now, let's add a method to create a directory using the name we pass in.

```ruby 
def create_group
    empty_directory(group)
end
```

And a method to put a file in the directory that uses a `template` method to copy a file from a pre-defined source location and evaluate it as if it were an ERB template.

```ruby
def copy_recipe
    template("recipe.txt", "#{group}/#{name}.txt")
end
```

For our generator to know where to create directories and add files, we can define a `source_root`.  
  
```ruby

def self.source_root
    File.dirname(__FILE__) + "/recipe"
end

```

Once we add that class, let's try running the command we've been working on `bundle exec exe/foodie recipe dinner steak`. This should complain that it is unable to find the `recipe.txt` file in any of the source paths that it looked in, which is the `foodie/generators/recipe` path that we defined in the `source_root` method.  
  
So, let's add that file!

```txt
##### Ingredients #####
Ingredients for delicious <%= name %> go here.

##### Instructions #####
Tips on how to make delicious <%= name %> go here.
```

Once we add that, let's try running `bundle exec cucumber features` and see how it goes.

