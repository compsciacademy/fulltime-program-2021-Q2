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
  