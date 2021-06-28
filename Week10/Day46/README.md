# Day 46  
  
Have a look at rails documentation. Feel free to Google as well, but there's an amazing resource available at your fingertips that will allow you to answer this question:  
  
What is the difference between `resource` and `scaffold` in the context of `rails generate`, e.g.

What is the difference between:  
```
bin/rails generate resource post title:string body:text
```
and
```
bin/rails generate scaffold post title:string body:text
```

A couple of ways to answer this are:   
  
1. Read the help menu  
  
```
bin/rails generate resource --help
bin/rails generate scaffold --help
```

2. Try them out and see what they do  
  
---

After playing around with them, it was pretty easy to find out precisely what the differences were. The help menu for generating a resource gives a good description that includes:  
  
_"Unlike the scaffold generator, the resource generator does not create views or add any methods to the generated controller."_  
  
## Exercise 01  
  
Create a new rails project with blog posts and users. Posts belong to users. Let's use [Devise](https://github.com/heartcombo/devise) for our user authentication.  
  