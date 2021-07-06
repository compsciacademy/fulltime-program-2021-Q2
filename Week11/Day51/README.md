# Day 51  
  
## Polymorphic Assocations  
   
Today, we're going to talk about [polymorphic associations](https://en.wikipedia.org/wiki/Polymorphic_association). Here are some relevant links:  
  
[Single Table Inheritance](https://en.wikipedia.org/wiki/Single_Table_Inheritance) | [Active Record Associations](https://guides.rubyonrails.org/association_basics.html#polymorphic-associations) | [RailsCast](http://railscasts.com/episodes/154-polymorphic-association)    
  
## Single Table Inheritance  
  
"_Single table inheritance is a way to emulate object-oriented inheritance in a relational database. Polymorphic association is a term used in discussions of Object-Relational Mapping with respect to the problem of representing in the relational database domain, a relationship from one class to multiple classes._" - [wikipedia](https://en.wikipedia.org/wiki/Single_Table_Inheritance)  
  
"_Relational databases don't support inheritance, so when mapping from objects to databases we have to consider how to represent our nice inheritance struc-tures in relational tables. When mapping to a relational database, we try to minimize the joins that can quickly mount up when processing an inheritance structure in multiple tables. Single Table Inheritance maps all fields of all classes of an inheritance structure into a single table._" - [Martin Fowler](https://www.martinfowler.com/eaaCatalog/singleTableInheritance.html)  
  
Create a new Rails app, and generate a user model: 

```
rails new test_sti -T -J 

```

Create a new model for Moderator and Admin, both of which inherit from User. However, we'll create them in a separate folder in the models folder. Rails will treat this as a module, and we'll be able to access these models using the double colon style: `User::Moderator`  
  
```ruby
# app/models/user/moderator.rb
class Moderator < User
  validates :first_name, :last_name, presence: true
end
```

```ruby
# app/models/user/admin.rb
class Admin < User
end
```

and of course, we need a User model `rails generate model User first_name last_name email`
```ruby
class User < ApplicationModel
  validates :email, presence: true
end
```

Run db migrations to set up the database and add users. Then hop into the rails console to see what we can do:

```
bin/rails db:migrate
bin/rails console
```

Now we can see that we can access `User`, `Moderator`, and `Admin` with the same interface methods, but the validations are different. All the children inherit from the parent, i.e. `Moderator` and `Admin` require an email before they can be saved, whereas `User` and `Admin` do not require `first_name` or `last_name`.  
  
```ruby
u = User.new
u.save
> false
u.email = 'drew@example.com'
u.save
> true

m = Moderator.new
m.email = 'mod@example.com'
m.save
> false
m.first_name = 'modperson'
m.last_name = 'lastname'
m.save
> true
```

All three classes use the same table in the database. This is a pretty simple version of STI, but it exemplifies a use case and how it can work.  
