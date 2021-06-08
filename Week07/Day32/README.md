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
  
## Adding a CLI
  
Since our gem is going to have a CLI, we will need to build it. We could start from scratch or import a pre-existing CLI library. Let's use the Thor gem, becuase it's a _gem_ of a _library_.  
  
```ruby
# mynatra.gemspec

# ...

spec.add_dependency "thor"

# ...

```
We could start by testing the CLI to ensure that it gives us a help menu if we want to know what we need to do... i.e. `mynatra --help` should display:
```
MyNatra - The Cool Fresh New Web Framework
==========================================

Commands
--------
-h, --help  displays this menu

```

We'll refine the actual output after we have a better idea of what it looks like.  

Let's actually add that CLI.  
  
```ruby
#lib/mynatra/cli.rb
require 'thor'

module MyNatra
  class CLI < Thor
  end
end
```

In order for our gem to know what do execute when we call `mynatra <some-command>`, we add an executable script to an `exe` directory in the root directory.

`mynatra/exe/mynatra`
```ruby
#!/usr/bin/env ruby

require "mynatra/cli"

MyNatra::CLI.start

```
And then we can run `chmod +x exe/mynatra` to ensure that the file is executable.  


## Gemspec Setup

The gemspec has some very helpful placeholder text that we should update (must change actually) before we are able to complete a `bundle install`. You can just change some of the strings to either valid-looking urls, or remove the TODOs, but of course it's much better to give proper information, especially if anyone else may ever use your gem.  

```ruby
# ...
  spec.name          = "mynatra"
  spec.version       = Mynatra::VERSION
  spec.authors       = ["Drew Ogryzek", "CA Anonymous"]
  spec.email         = ["drew@vancouvertechpodcast.ca", "youdontknow@example.com"]

  spec.summary       = "MVC Web Framework"
  spec.description   = "MVC Web Framework that builds on top of Sinatra"
  spec.homepage      = "http://MyNatra.example"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://MyNatra.example/sourcecode"
  spec.metadata["changelog_uri"] = "http://MyNatra.example/changelog"
# ...
```

Now, we can run `bundle install`, and then `bundle exec exe/mynatra` to see that everything just works.

```
Commands:
  mynatra help [COMMAND]  # Describe available commands or one specific command
```
