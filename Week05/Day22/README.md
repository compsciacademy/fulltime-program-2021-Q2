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
  
