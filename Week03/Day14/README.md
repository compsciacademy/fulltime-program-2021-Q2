# Day 14  
  
Last time we spoke to our customer who wanted the employee database application, he gave us a list of some [custom queries](https://github.com/compsciacademy/fulltime-program-2021-Q2/tree/main/Week03/Day13#exercise-01) he wanted to be supported.  
  
```
find employee where email_address equals drew@drew.com
find employees where salary is greater than 25
find employees where vacation_days are less than 10
find employees where email_address is like *@company.com
```

Today, he was very pleased with the progress displayed at the demo(nstration). 

## Exercise 01   
  
### a.) However...

He did realize that he had neglected to ask for some additional features that he _really needs_ to be supported by version 1 of the system otherwise it will be _completely unuseable_ for their company.  
  
The company regularly has projects that are overseen by a project manager from within the company, and often have up to 3 to 5 contract workers from various contracting companies.  
  
We will need to be able to add contract workers, with similar functionality as employees, e.g. `find contractor where email_address equal joe@joeswelding.com`, etc. And also have a way to track projects, who is managing a projet, and which employees and contract workers are assigned to the projects.  
  
We will also want to be able to support some of the following queries (NOTE: this is not an exhaustive list - more items may be added as the client remembers what he needs):
```
find contractor where email_address is may@HeyItsMay.com

find project where city is 'los angeles'
find projects where contact_employees include frank@heyitsfrankies.ca
find projects where manager.email_address is like *@company.com
```
  
There are a lot of ways that we could potentially develop our system to handle such queries. There are also a couple of cases that we might need to take some time to think through more thoroughly, which might also require some testing, or building of throwaway code, etc.  
  
In the above, there are 4 queries. 2 of them are quite similar, if not identical to queries we have already solved for:
```
find contractor where email_address is may@HeyItsMay.com
find projects where contact_employees include frank@heyitsfrankies.ca
```

The other two, however, introduce some additional difficulty that will have to be accounted for, both by our methods of parsing queries, and of course our methods for handling them.  
  
```
find project where city is 'los angeles'
```
Introduces single quotes around a city name, that should be parsed as such.  
  
```
find projects where manager.email_address is like *@company.com
```
Introduces an interesting concept: `manager.email_address`. What does this mean for our system? What does it mean for the query? What does it mean for our parser?  
  
These are some problems we will need to resolve. One way to go about automating solutions to problems is to analyze a manual approach until it can be described algorithmically. Optimizing the solution is not typically the main goal at this point.  
  
Here's an example of a query parser that we came up with:  
  
```ruby
def parse_query_string(query_string)
    left, right = query_string.split(" where ")
    query_type, record_type = left.split(' ')
    query = {
        :query_type =>  query_type,
        :record_type => record_type,
        :attribute => right.split(' ').first,
        :value => right.split(' ').last,
        :evaluator => right.split(' ')[1..-2].join(' ')
    }
end
```

This will take a query string and return a hash with some key/value pairs that will prove to be quite useful in our endeavors. However, it does not completely solve the problem for us. Nor does it fully solve the problem of parsing query strings to satisfy all the queries our system needs to handle.  
  
### b.) Thinking Through The Problem

Let's see if we can break down the problem(s) we have to resolve into steps that we can tackle one by one. This way, the entire problem which can seem insurmountable is split into chunks whose solutions are more readily visible.  
  
Firstly, we have a working system that does all the things we wish to do with employees. We need to add contractors with similar attributes, and projects. We may still need to gather some requirements for what attributes and/or behavior these things may have.  
  
There are a couple of approaches we can take to breaking down the problem space. One obvious (maybe?) choice is to separate the new features into features that can be resolved by mofifying existing functions, e.g. `parse_query_string` cannot properly handle all of the new query strings, but if it could, then we could impelent support for them without modifying its interface.  
  
Currently our system works with employees, but not with any other records. Can we start there? How about adding Contractors? Can we get a system working that allows us to run our queries on employees and contractors?  
  
Can we then add projects, with at least the attributes necessary to be able to fulfill the query requirements as specified?  
  
Once we have added Contractors and Projects to the system, we can then work on the easiest of the queries, i.e. the ones that require the least modificication to existing functionality.  
  
Once we are at that stage, we can either demo the project and maybe even hand it over to the customer to start testing, or we can continue working on it, adding in support for the more complex features. Another possibility is that the customer will give some feedback and something will need to be tweaked, or the scope may change... again.  
  
### c.) Now, it's your turn...  
  
We have our problem set up, our solution is sight! Now all that's left is time, and code... let's see where we go with this. Fortunately, the client is on the West Coast and isn't expecting a demo until 9am Pacific, which give you until lunchtime tomorrow to have something to demonstrate!  
  