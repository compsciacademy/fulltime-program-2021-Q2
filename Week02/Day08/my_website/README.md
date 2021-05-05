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
  
Bonus: Use git to commit whenever something meaningful happens.  

