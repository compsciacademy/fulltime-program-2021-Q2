# Day 22  
  
Last time, we had a peak at Sinatra. In order for us to use it (it's a mini-web framework, btw), we decided to install and use RBENV (to manage our ruby environments --- versions), and the sinatra gem (libary), which complained that we also needed a server handler, and offered some suggestions: thin, puma, reel, HTTP, webrick.  
  
We wanted to take a look at the [`get`](https://github.com/sinatra/sinatra/blob/cf404526373298f06a59e1a129b6cdf8282ae216/sinatra-contrib/lib/sinatra/runner.rb#L69-L71) method and see if we could figure out what it does

```ruby
def get(url)
    Timeout.timeout(1) { get_url("#{protocol}://127.0.0.1:#{port}#{url}") }
end
```  
  
## Exercise 01  
  
Read through either the Sinatra codebase or documentation (or both) and see what other methods are available. Try to use at least 1 more!  
  
## Exercise 02  
  
Let's create a web app! Do you like music? Do you like songs? Let's make an app that allows us to create a list of songs we like with links to watch their videos on YouTube™  
  
For this, we will have a look at something called `.erb` files, which is short for _embedded_ ruby. This is just an HTML file (basically) in which you can run some Ruby code.  
  
Here's the Legend of HTML (NOTE: This is not actual HTML)  
```HTML
<element attribute="value">
    <void-element>
</element>
```
And here are some examples of actual HTML elements.  
  
```html
<!DOCTYPE html>
<html>
    <head>
        <title>My Web Page</title>
    </head>
    <body>
        <h1>I am the head header</h1>
        <section id="entrees">
            <div>
                <p></p>
                <ul>
                    <li>Meat sauce pie</li>
                    <li>Burger fried rice</li>
                    <li>Chicken a la steak</li>
                </ul>
            </div>
        </section>
        <section id="desserts">
        </section>
        <section id="drinks">
        </section>
    </body>
</html>
```

According to the [Google HTML & CSS Styleguide](https://google.github.io/styleguide/htmlcssguide.html), "Omit optional tags (optional)."  
  
So, how should our application function? We want a display that looks something like this:  
  
artist | title  
--- | ---  
Eric Herman | [The Tale of the Sun and the Moon](https://www.youtube.com/watch?v=UoWFJ690U6E)  
  
We should be able to add songs to the list.  
  
