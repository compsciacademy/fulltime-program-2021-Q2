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
