# Day 47

Today, let's put some things together, and build out a TODO app, keeping things somewhat simple, using Rails with PostgreSQL and React!

This should help to bring together a few of the concepts we have covered, while introducing a couple of technologies that 
we haven't looked at yet.

When you create a new rails project, you can specify which database driver to use with `-d`

```
rails new my-todo -d postgresql
```

When using PostgreSQL, we will need to _create_ the db with `bin/rails db:create`

You may have to set db permissions for your user to be able to create postgresql databases. To do so, you will want to switch users to the postgres admin, then alter permissions on your user.

e.g.

```
# switch user to postgres (admin)
su postgres

# log into the PostgreSQL console
psql

# in the console list users
\du

# create a user (if you don't have one)
CREATE USER drewnix;

# alter the permissions of an existing user
ALTER USER drewnix CREATEDB;

# quit the psql console
\q
```

Since we have decided to use ReactJS for our frontend, we will need to _install_ it. With Rails, we have [Webpacker](https://edgeguides.rubyonrails.org/webpacker.html) which is a Rails _wrapper_ around [Webpack](https://webpack.js.org/). We can run:

```
bin/rails webpacker:install:react
```

Now that we are all set up, we're ready to get to work on the functionality of our app.  
  
```
bin/rails generate controller Todos index
```

Update the application view `application.html.erb` to use the `index.jsx`

Let's generate a model for todos, with 2 fields, one for the todo name or title, and another that we can use to show whether it is complete or not.  
  
```
bin/rails generate model Todo title:string complete:boolean
```

We can use `yarn` to add [Bootstrap](https://getbootstrap.com/docs/4.0/getting-started/introduction/) to our app:

```
yarn add bootstrap jquery popper.js
```

Add a bunch of react components and you're good!  
  
## Homework Excercises  
  
  1. Update the Pending component such that a TODO item is moved to the Complete List if checked, not on reload.
  2. Also, update the Complete component so that there is an onClick event to update its complete field, and move it to the Pending component.
  
Tomorrow, we'll have a look at [Build Your Own React](https://pomb.us/build-your-own-react/) to step through some of the most common features of React, and how they work.  
  