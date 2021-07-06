# Day 51  
  
## Polymorphic Assocations  
   
Today, we're going to talk about [polymorphic associations](https://en.wikipedia.org/wiki/Polymorphic_association). Here are some relevant links:  
  
[Single Table Inheritance](https://en.wikipedia.org/wiki/Single_Table_Inheritance) | [Active Record Associations](https://guides.rubyonrails.org/association_basics.html#polymorphic-associations) | [RailsCast](http://railscasts.com/episodes/154-polymorphic-association)    
  
## Single Table Inheritance  
  
"_Single table inheritance is a way to emulate object-oriented inheritance in a relational database. Polymorphic association is a term used in discussions of Object-Relational Mapping with respect to the problem of representing in the relational database domain, a relationship from one class to multiple classes._" - [wikipedia](https://en.wikipedia.org/wiki/Single_Table_Inheritance)  
  
"_Relational databases don't support inheritance, so when mapping from objects to databases we have to consider how to represent our nice inheritance struc-tures in relational tables. When mapping to a relational database, we try to minimize the joins that can quickly mount up when processing an inheritance structure in multiple tables. Single Table Inheritance maps all fields of all classes of an inheritance structure into a single table._" - [Martin Fowler](https://www.martinfowler.com/eaaCatalog/singleTableInheritance.html)  
  
