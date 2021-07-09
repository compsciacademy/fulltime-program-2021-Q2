# Day 54  
  
Today, we want to take a look at [mail](https://guides.rubyonrails.org/action_mailer_basics.html) and [file storage](https://guides.rubyonrails.org/active_storage_overview.html) with [Ruby on Rails](https://guides.rubyonrails.org/).  

## Mail with Rails  
  
When you want to do a thing, it's usually helpful if you have a thing in mind to do. It's especially helpful if you are able to articulate it.  
  
There are several reasons for this, but one is that you can use the "thing" you have in mind as a sort of anchor point or reflection point for solidifying concepts. This is better than just blindly following a tutorial or documentation, because it pushes you to apply the concept, rather than just the steps.  
  
With that in mind, _the thing_ we have in mind to do is to send mail in our Projects project to a user whose discussion has received a comment, when it receives a comment.  

---

## Step One -- Follow the Guide  
  
In our projects app, let's create a mailer for our users. Do this on a new branch, so we can easily get back to where we started if we decide to do something different later.  

```
bin/rails generate mailer user
```
  
## Storage with Rails  
  
In our Projects project, we want to be able to add a Photo (or maybe a list of photos, ala a [carousel](https://getbootstrap.com/docs/5.0/components/carousel/)) to a project.  
  
