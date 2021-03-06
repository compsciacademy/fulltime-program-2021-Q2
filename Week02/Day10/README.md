# Day 10

**Homework Review**  
  
[Day09 Homework Review](https://github.com/compsciacademy/fulltime-program-2021-Q2/blob/master/Week02/Day10/homework_review/Homework.md)  
  
## Working with Git  
  
Break up the classes from yesterday's homework into multiple files, and add the necessary `require` or `require_relative` statements. Create a repository on GitHub, and push your code there for some review!  
  
**Git command review**  
  
```sh
git init
git add <filename>...
git status
git commit -m <message>
git log
git help <command>

```

Those are very useful git commands, as we will be using them all the time. Some other git commands are useful for communicating with remote repositories. A remote repository is a repository (or directory) that is located on a _remote_ (or different) machine (computer). An example of a location where a remote repository might be is github.com (github.com is an address).  
    
When we create a new repository on GitHub, it gives us some instruction on commands we can use. For example, if you do not have an existing git repository:

```
GITHUB_USERNAME=<my-username>
ADDRESS_TO_MY_REPO=git@github.com:$GITHUB_USERNAME/competition_cats.git
```

```sh
echo "# competition_cats" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin $ADDRESS_TO_MY_REPO
git push -u origin main
```
Or, if you do have an existing repository:

```sh
git remote add origin $ADDRESS_TO_MY_REPO
git branch -M main
git push -u origin main

```

You may notice an option to choose between HTTPS and SSH:

HTTPS: `https://github.com/$GITHUB_USERNAME/competition_cats.git`  
SSH: `git@github.com:$GITHUB_USERNAME/competition_cats.git`  

```sh
git init
git add competition_cats.rb
git commit -m 'Initial commit'

git remote add <REMOTE_NAME> <REMOTE_ADDRESS>
```

If you'd like to setup an SSH key, make sure to follow [the guide](https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account).  

**Create a New Branch**  
  
```sh
git branch organize-structure
git branch --list


```
The asterisk `*` shows which branch we are currently on.  
  
Working with branches

```sh
git branch --list
git branch <branchname> # create a new branch
git checkout <branchname> # checkout a new branch
git checkout -b <branchname> # create and checkout a new branch
git branch --delete <branchname> # deletes a branch
```

A potential workflow:
```sh
git branch new-feature
git checkout new-feature
# do some work
git add -A # stage all changes for commit
git commit -m 'Adds a new feature'
git push origin new-feature # pushes new-feature branch to origin (github)

```

Some more commands
```sh
git fetch # downloads refs from remote
git diff origin/master # compare differences between fetched refs and current branch
git pull origin master # pull changes from origin remote to master branch
git merge origin/master # merge origin/master refs into current branch

``` 

To set a branch as the _main_ branch, you can use the `-u` or `--set-upstream-to` option. If we wish to rename our `master` branch to `main`, for example, here is the flow:

```sh
git branch -m master main # move (rename) master to main
# rename master to main on github, if exists
git branch --set-upstream-to origin/main main
git push -u origin main # (optional) sets main as the _main_ branch and pushes
git remote set-head origin -a # updates origin (github) to use main

```

## Working with Yield, and More Robust Testing

Let's think through our testing framework and a couple of ways we could make it somewhat more rubust! We'll get to [yield](https://ruby-doc.org/docs/keywords/1.9/Object.html#method-i-yield) in a moment, but before we do, let's look at something cool!  
  
```ruby
class Person
    attr_reader :name

    def initialize(name)
        @name = name
    end

    def my_name
        "#{name} lol #{name}"
    end

    def my_favorite_thing
        "#{name}: soup"
    end

    def my_age 
        "#{name}: 12 years old"
    end
end

p = Person.new("lolly")


#find methods that begin with my_
puts Person.instance_methods.grep(/my_/)

['my_age', 'my_name', 'my_favorite_thing']
```

## Exercise 01  
  
Using our newly acquired git-foo, continue breaking out the competition cats code into an organized (or somewhat organized) codebase, while adding a user interface (and functionality) that allows 2 players to compete. If there is only 1 player, then an automated player (affectionately called, "the computer") will play against the player.
  
It is your choice whether to persist data. However, do make sure to have branches, commits, and pull requests to show the history of your progress.  
  