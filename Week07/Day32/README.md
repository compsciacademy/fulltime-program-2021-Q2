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

## Adding Generators  
  
Let's try adding a couple of commands. We can start with an idea of what we want to put in, and what we hope to get out.  
  
We actually may even have some [precedence](https://github.com/compsciacademy/fulltime-program-2021-Q2/tree/main/Week07/Day31#exercise-01) for this.  
  
Here are some example commands (i.e. _inputs_):
```
mynatra new MyBlog && cd MyBlog
mynatra resource post title body
mynatra resource comment body
```
If we run `mynatra new MyBlog` we expect the following output:
```
MyBlog/
  |-app.rb
  |
  |-views/
    |
    |-footer.erb
    |-getting_started.erb
    |-header.erb
  |
  |-public/
    |
    |-scripts/
      |
      |-main.js
    |-styles/
      |
      |-main.css
  |
  |-gemfile

```
For a working example, have a look at [Day28/MyBlog](https://github.com/compsciacademy/fulltime-program-2021-Q2/tree/main/Week06/Day28/MyBlog).  
  

```ruby
require 'thor'

module MyNatra
  class CLI < Thor
    desc "new [PROJECT]", "Creates a new directory with MyNatra project scaffolding"
    def new(project)
      MyNatra::Generators::Scaffold.start([project])
    end

  end
end

```

Now that we have an idea what our _new_ command will do, we need to create the Generator to support it. That can go in `lib/mynatra/generators/scaffold.rb`  
  
```ruby
require 'thor/group'

module MyNatra
  module Generators
    class Scaffold < Thor::Group
      include Thor::Actions
      argument :project, type: :string

      def create_project
        empty_directory(project)
      end

      # now, we can fill in the rest of the scaffolding
      # with the base project.
      #
      # copy_file(source, *args, &block)
      # directory(source, *args, &block)
      #
      # args.first is used as the destination, if given.

      def copy_base
        directory('./base', project)
      end
    end
  end
end

```

We can use the methods that `Thor::Actions` give us, `copy_file` and/or `directory` to copy some base scaffolding. In order to do this, we need to actually _have_ that base scaffolding, which we know is arranged like this:

```
MyBlog/
  |-app.rb
  |
  |-views/
    |
    |-footer.erb
    |-getting_started.erb
    |-header.erb
  |
  |-public/
    |
    |-scripts/
      |
      |-main.js
    |-styles/
      |
      |-main.css
  |
  |-gemfile

```

Now, we just need to define _each_ of those files.

`app.rb`
```rb
require 'sinatra'

# require all controllers in the ./controllers/ directory
controller_paths = Dir["./controllers/*.rb"].each { |file| require_relative file }
controllers = controller_paths.map { |controller_path| controller_path[/controllers\/(.*?)_controller/m, 1] }
controllers.each { |controller| use Object.const_get("#{controller.capitalize}Controller") }

```
  
`contollers/getting_started_controller.rb`
```ruby
class GettingStartedController < Sinatra::Base
  get '/' do
    erb :getting_started
  end
end

```

`views/getting_started.erb`
```html
<%= erb :header %>

<h1>Getting Started with MyNatra</h1>

<p>Here's all the stuff you need to know to get started</p>

<%= erb :footer %>
```

`views/header.erb`
```html
<!DOCTYPE html>

<link rel="stylesheet" src="styles/main.css">
<script src="scripts/main.js"></script>

```

`views/footder.erb`
```html
<div class=footer>
    <p> put something here.
</div>
```

`public/styles/main.css`
```css
body {
  background-color: #ee67f2;
  color: #f71e59;
}

```

`/public/scripts/main.js`
```js
// main.js

```

Now, we should be able to run `bundle exec exe/mynatra new MyBlog` and have a base project set up for us. Great!  
  
Let's move on to the next step...

```
cd MyBlog
bundle exec exe/mynatra resource post title body
```

And make that generate the required files for performing CRUD operations on the post resource, including views, controllers, models, and whatever else we may need.  
  
