# Day 28  
  
## MyNatra Continued...  
  
What routes do we need to have to support CRUD operations on a resource?  
  
**Create**: add data attributes that can be saved somehow for later retreval.  
  
**Read**: retrieve data attributes for an entity.  
  
**Update**: replace data attributes for an entity.  
  
**Delete**: delete data attributes for an entity (delete the entity).  
  
**Required Routes**  
  * new: prepare [and serve] a resource to collect its data
  * create: store the resource data
  * find: retrieve [and serve] a resource
  * update: updates resource data
  * delete: removes resource [and/or its data]
  * index: list all of a given resource
  
Continuing with our example from the `MyBlog` project, let's make a modification, and instead of a _user_ resource, let's work with blog _post_ resources.  
  
```
mynatra resource post title body
```

This should create a `Post` resource with all models, views, routes, etc. required to perform all CRUD operations.  
  
However, before we begin any work on the MyNatra CLI application...  
  
## Exercise 01  

Flesh out what precisely we expect the output to be of that command. That is, manually create an application that satisfies all of the requirements above, before we automate it, so we have something to compare (i.e. a goal).  
  
We've done that in the [MyBlog](/MyBlog/) directory. But there are some design decisions we may still choose to make later, as well as various features that we have yet to add...  
  
