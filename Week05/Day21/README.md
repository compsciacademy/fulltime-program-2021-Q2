# Day 21

Write some automation that adds at least 10 users to your system, using at the coded functionality, and gives them various scores and points, etc. whatever your system gives, also using the coded functionality. This should result in some of them having higher scores than others, and you being able to select a top 3.  
  
Please write your automation in such a way that you can adjust the number to easily create 100, 1000, or 10000 users in your system. This will give us a larger scope of users to work with, if desired.  
  
Another ask is to create a pull request against this repository. We'll walk through that together with this README, as well as with today's catch-up exercise, which will highlight the _main point_ of what our previous exercise aimed to get at.  
  
---

## Exercise 01  
  
Create a program that takes a number, and creates (writes to disk) that number of users in the system. E.g. 15 will create 15 users.  
  
Additionally, you should be able to view all users, view (and edit/update) a single user, and delete a user. Or, create an individual user with your own custom inputs.  
  
## Exercise 02  
  
Welcome to the World Wide Web!  
  
We have some reading and catching up to do. There are some amazing resources, and we will familiarize ourselves with them over the coming days.  
  
  * [ietf - HTTP Protocol](https://datatracker.ietf.org/doc/html/rfc2616)
  * [Mozilla](https://developer.mozilla.org/en-US/docs/Web/HTTP)
  * [W3.org](https://www.w3.org/Protocols/)
  
  
For now, we'll just jump in and start to play with some code. Let's start with [Sinatra](http://sinatrarb.com/), because it's a gem of a library! ;)  
  
The example Sinatra wants us to start with is:  

```ruby
require 'sinatra'
get '/frank-says' do
  'Put this in your pipe & smoke it!'
end

```

**Part 1**  
  
See if you can get this to work on your machine.  
  
**Part 2**  
  
Look at the [Sinatra source code](https://github.com/sinatra/sinatra), and see if you can figure out where the `get` method is defined and _how_ it works.  
  