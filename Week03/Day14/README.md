# Day 14  
  
Last time we spoke to our customer who wanted the employee database application, he gave us a list of some [custom queries](https://github.com/compsciacademy/fulltime-program-2021-Q2/tree/main/Week03/Day13#exercise-01) he wanted to be supported.  
  
```
find employee where email_address equals drew@drew.com
find employees where salary is greater than 25
find employees where vacation_days are less than 10
find employees where email_address is like *@company.com
```

Today, he was very pleased with the progress displayed at the demo(nstration). However...

## Exercise 01   
  
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
