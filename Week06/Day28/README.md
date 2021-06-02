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
  
---  
  
## Working with SQL & PostgreSQL  
  
SQL or Structured Query Language is a DSL (a domain-specific language) for working with relatational data. We are going to take a look at using SQL (the DSL) and using a Relational Database Management System, PostgreSQL, which will provide an _interface_ for using SQL to work with data.  

Depending on your operating system, there are some different ways to install [PostgreSQL](https://www.postgresql.org/download/), which range from downloading and clicking on an executable then clicking through a GUI installer to just running a command such as `<package-manager> install postgresql`, which is likely how you will be installing if you're using macOS, Linux, or WSL on Windows...  
  
**Linux (Ubuntu/WSL)**    
  
Install:  
```
sudo apt update
sudo apt install postgresql postgresql-contrib
psql --version
```

The default admin user is `postgres`. We'll need to set a password for it.
```
sudo passwd postgres 
```

Start and Stop the PostgreSQL service
```
sudo service postgresql start
sudo service postgresql stop
```

Run the `psql` command as the user `postgres` (the default admin user).
```
sudo -u postgres psql
```

This will give a postgres command line interface. Type in "help" for help.
```
postgres=# help
You are using psql, the command-line interface to PostgreSQL.
Type:  \copyright for distribution terms
       \h for help with SQL commands
       \? for help with psql commands
       \g or terminate with semicolon to execute query       
       \q to quit
```

List the databases with `\l`  
```
postgres=# \l
                              List of databases
   Name    |  Owner   | Encoding | Collate |  Ctype  |   Access privileges   
-----------+----------+----------+---------+---------+-----------------------
 postgres  | postgres | UTF8     | C.UTF-8 | C.UTF-8 |
 template0 | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
           |          |          |         |         | postgres=CTc/postgres 
 template1 | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
           |          |          |         |         | postgres=CTc/postgres 
(3 rows)

postgres=#
```