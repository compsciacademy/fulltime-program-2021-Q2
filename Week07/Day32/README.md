# Day 32

Using [Bundler](https://bundler.io/) to create our own web framework library, with [Sinatra](http://sinatrarb.com/), [Thor](http://whatisthor.com/), and [ActiveSupport](https://github.com/rails/rails/tree/main/activesupport) as dependencies.  
  
## Getting Started
  
First, we can generate gem scaffolding with bundler by running `bundle gem <gem-name>` in this case, we're building a tool that generates scaffolding for us, i.e. a web-framework around Sinatra. We'll call it MyNatra, as in My Sinatra.  
  
```
bundle gem mynatra
```

This creates some files and folder heirarchy for us. We have a `Gemfile`, `Rakefile`, `mynatra.gemspec`, and `bin/` and `lib/` directories. While using bundler to manage the development and ultimately production environments and setup for our gem, we can use the `mynatra.gemspec` to specify any dependencies.  
  
For dependencies that we will be using only during development, such as testing frameworks for example, we can specify them with `add_development_dependency`. Let's do that for `rpsec`, `cucumber`, and `aruba`.  
  
```ruby
# mynatra.gemspec

# ...
spec.add_development_dependency "rspec"
spec.add_development_dependency "cucumber"
spec.add_development_dependency "aruba"

# ...

```

We can then go ahead and add some specs or feature tests. 
