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
  
## Exercise 01  
  
Sign up for Heroku, if you haven't already. Have a look at the documentation, and see if you can deploy your application to Heroku!  
  