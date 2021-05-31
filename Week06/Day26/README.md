# Day 26  
  
Sinatra is a pretty fun library to work with. One thing that we can do is use partials to reuse _parts_ of code. A potentially good example for this with the application we developed could be our navigation.  
  
```html
<!-- ... -->

<nav>
<a href="/">Home</a> | <a href="/settings">settings</a>
</nav>

<!-- ... -->
```

We used this same navigation on any page that needed to display it. Which, in the case of our app was _every_ page.  
  
We could move it out to its own file, `nav.erb` within the `views/` directory, and then call `<%= erb :nav %>` within an erb file in the `views/` directory, and now we have a single place to modify or work with our navigation.  
  
---  
  
[Heroku](https://www.heroku.com/) originally only supported Ruby, I think, and was (and still is) very popular for hosting Ruby (and other) applications.  
  
## Exercise 01: Heroku  
  
Sign up for Heroku, if you haven't already. Have a look at the documentation, and see if you can deploy your application to Heroku!  
  
Heroku needs to know what language your app is using, what dependencies it requires and where to get them.  
  
For our app, we will want to add a couple of files.  
  
One, a [Gemfile](https://bundler.io/man/gemfile.5.html), which is a common file in Ruby for showing dependencies. 

```
source 'https://rubygems.org'
gem 'sinatra'

```

Heroku will also want to have a configuration file, in Ruby we typically use a [`config.ru`](https://devcenter.heroku.com/articles/rack#sinatra).  
  
```ru
require './app'
run Sinatra::Application
```

After installing Heroku, check out the [Deploying with Git](https://devcenter.heroku.com/articles/git) documentation.  
  
If you initialize a git repository before running `heroku create`, it will automatically set a heroku remote for you.  
  
```
heroku create <app-name>
git push heroku master
git apps:open <app-name>

# view heroku commands
heroku commands

# get help for a command
heroku help <command>
heroku help logs

# steam logs for an app
heroku logs -t --app=<app-name>
```

---

## Exercise 02: `__FILE__`  
  
If `puts __FILE__` in a ruby script, it will output the name of the file. Can you imagine some use-cases for doing this?  
  
What happens to `__FILE__` when a script is run, and requires other files that use this variable?  

Find out!

```ruby
# run.rb
require './lol'

class App
    def run
        Lol.new.info
        puts "I am run.rb: #{__FILE__}"
    end
end

App.new.run

```

```ruby
# lol.rb
require_relative './what/yo'

class Lol
    def info
        Yo.new.info
        puts "I am lol.rb: #{__FILE__}"
    end
end

```

```ruby
# what/yo.rb

class Yo
    def info
        puts "I am yo.rb: #{__FILE__}"
    end
end

```

## Exercise 03: Procs & Lamdas

```ruby
# What's the difference between a proc and a lambda?
#
# To really understand the difference, let's put them both to use.

# Instiate a proc and a lambda
l = lambda { |x, y| x.times { puts y } }
p = Proc.new { |x, y| x.times { puts y } }

# Take note of what type of class each of these are
l.class
p.class

# When envoking lambdas and procs, we use `call`, e.g.
# Try calling each to see what they do with both the 
# correct number of arguments, and too many arguments 
# (or even not enough)
l.call 1, 2
l.call 1, 2, 3, 4
l.call 6
p.call 1, 2
p.call 1, 2, 3, 4
p.call 6

# Define a method that takes a proc or lambda as a
# parareter and runs some code without passing the
# parameters to the proc.
def proc_tester_without_params(lambda_or_proc)
  # your code here
end

# Define a method that takes a proc or lamdba as a 
# parameter and runs some code that passes too many
# arguments to it
def proc_tester_with_many_params(lambda_or_proc)
  # your code here
end

# Pass procs and lamdbas into the methods and observe
# the outcome...
proc_tester_without_params l
proc_tester_without_params p

proc_tester_with_many_params l
proc_tester_with_many_params p

```
