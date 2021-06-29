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