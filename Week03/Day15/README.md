# Day 15

[Yesterday](https://github.com/compsciacademy/fulltime-program-2021-Q2/tree/main/Week03/Day14#day-14) we set out on developing some of the final features for our Version 01 of the Project Management System our customer wanted, when he originally asked us for a Employee Database program.  
  
Some of the specifications had typos or were otherwise misleading. After a meeting with the client today, we have some new (or better) requirements.  
  
The queries we wanted to be able to support should look something like this:
```
find contractor where email_address is may@HeyItsMay.com
find project where city is 'los angeles'
find projects where contactor.email_address equals frank@heyitsfrankies.ca
find projects where manager.email_address is like *@company.com
```

We can see the use of `<record_type>.<attribute>`  as an _attribute_ in the queries. What this means, and how we will decide to implement it are up to you to determine, design, and develop.  
  
## Exercise 01  
  
### a.) Additional Requests...
  
There are additional requests now as well, for example
```
find project.contractors where contractor.email is like *@notanemployee.com
find contractors where project.manager.name is joe
```

We should also be able to find projects by date:
```
find project where project.start_date is greater than 01/01/1900
find project where project.start_date is greater than 10/05/2018 and project.end_date is less than 10/05/2019
```

The client also requests that the UI supports all interactions with projects and contractors that it does with employees, except of course allowing either to log in.  
  
There is an additional requirement. That is that a project manager should be able to see a project that they are managing as well as the employee information for employees who are assigned to that project.

## Exercise 02  
  
There's a neat thing called environment variables that we are about to talk about now! Woo hoo. Are you excited? I know I am. :)  
  
Environment variables are, as the name implies, variables in the environment. What does that mean? Well, you can set variables at run time, and your application can have access to it. Env vars are often used for configuration variables, and they are fun, cool, and one might even say ... a pleasure to use.  
  
Try this out! Create a file `app.rb` that has the following script:

```ruby
# app.rb
puts "Hi there #{ENV['name']}. I'm a Ruby script!"

```

Then run the script with the command `name='<your-name>' ruby app.rb`, e.g. `name=Drew ruby app.rb` and see what happens.
  
`ENV` is a hash. We can maybe take a look at what's inside at runtime.

**a.)** Write a script that prints out the environment variables by key and value that exist at runtime.

```ruby

puts "Key  |  Value"
ENV.each do |key, value|
    puts "#{key}: #{value}"
end
```

**b.)** Write an application that handles records of users, which have username and email addresses (and that's it). Here's the fun part! Write it in such a way that:
  - 1.) The data persists
  - 2.) There are functional tests that can read/write to a test data store
  - 3.) Uses env vars to differentiate between application runtime and test runtime (i.e. to use different persistent data depending on whether it is running live or testing)  
    