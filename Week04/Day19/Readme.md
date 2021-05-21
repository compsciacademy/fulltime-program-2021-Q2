# Day 19  
  
One thing that we have not yet discussed is indentation. This is an interesting point that some have very strong opinions about. Typically, there will be some conventions that a language community tends to adhere to. It's generally an OK practice to do so.  
  
In VS Code, we can set up our Ruby language specific settings in the `settings.json`  
  
```json
// ...
	"editor.tabSize": 2,
	"editor.insertSpaces": true,
	"editor.detectIndentation": true,
// ...
```
This should give us the general indenting as indicated in styleguides such as the [Rubocop Style Guide](https://github.com/rubocop/ruby-style-guide)

## Exercise 01  
  
Today's first exercise is going to be a little bit of a review. We talked about a simple login system, where a user could log in using an email (or other identifier such as name or username) and a password. We also talked about storing the password, not in plaintext, but using encryption. We even went so far as to develop our own encryption algorithm.  
  
Take a little time and write an application that allows a user to log in, using an email and password. Use the encryption algorithm you developed last time to store (and verify) the password.  
  
---

In the solution we just came up with we added a hash `session` that we can use to add other things we might wish to use.  
  
```ruby
# ...
      if @session['user']
        puts "CURRENT USER: #{@session['user'].email}"
      else
        puts "Create a new user or login to be greeted"
      end
# ...

```
  
## Exercise 02  
  
Extend our current application with user profiles. That is, add a profile for a user that can be saved, and also preferences for that profile that can be added to a current session on user login.  
  
For example, preferred greeting for morning, afternoon, evening, and night time.  

```
Merry morning to ya drew@example.com!
Spendid evening drew@example.com.
What a lovely after 12 o'clock it is drew@example.com
```

## Exercise 03  
  
Let's revisit our Competition Cats game. We would like to be able to have N number of players. What does a play do? What are requirements for players to do what they do?  
  
A player needs a cat in order to enter into any competition. We will need to decide whether players start with a cat, n cats, or there are ways to acquire cats. Further, do cats have a life expectancy? Do they need to be replaced? Are there win/lose end-game (entire game/career) scenarios? These are things that you can determine on your own, as it is your game.  
  
It is important however, that you do determine some of these things as you will need to program them. Having an understanding of what your goals are is going to be helpful in reaching them. Without clear goals, the path can quickly become unclear.  
  
Some examples:
  Players start with tokens.
  Tokens can be used to purchase cats.
  Pet stores sell cats.
  Pet stores can be visited (each time a pet store is visited, it may or may not have cats)
  
