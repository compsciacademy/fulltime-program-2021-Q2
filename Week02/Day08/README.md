# My Readme

This file repository is for my person version control learning.  
  
Today, I'm starting with git.

## Today's Git Commands

```
git init
git add <filename>
git commit -m '<commit message>'
git status
git log

git help <command>
```

**Exercise 01**  
  
If you haven't been following along, create a new directory, add a file or some files, initialize it as a git repository, and make some commits.  
  
Note: Try to have the commits be in "_meaningful_" chunks.  

## Error Handling  
  
Let's start with [Standard Error](https://ruby-doc.org/core-2.5.1/StandardError.html)

```sh
touch lol.rb
```

```rb

raise StandardError.new("This is an error message")

```

**Exercise 02**  
  
Create 2 functions that raise errors if a condition is met. You can do this in a `begin; rescue; end` block, and handle those errors.  
  
Try to be creative.  
  
NOTE: Add a commit whenever something meaningful happens.

## Testing  
  
Testing is an interesting area of software development. How good your tests are is really dependent on how well you write them, and whether you use them.  
  

**Exercise 03**  
  
We have discussed some tests in `user_tests.rb`. Have a look and finish the `email_address_format` test on your own.


```ruby
def email_address_format(email_address)
    # ensure that email addresses match the pattern:
    # `<string>@<string>.<string>`

end
```

**Exercise 04**

Continue with the user class, and this time add read & write methods that will persist user data to disk.

Here's an example workflow that highlights the expected behavior

```shell
? irb
> load "./user.rb"
> user = User.new("jo", "jo@dot.com")
> user.save
> user = User.new("corey", "corey@dot.com")
> user.save
> exit

? irb
> load "./user.rb"
> User.all
=> "jo, jo@dot.com", "corey, core@dot.com"
> exit
? 
```
Before building any functionality into the user class, make sure to write a test that fails, then make it pass. Each time you complete a test, make a commit that explains what you did.  
  