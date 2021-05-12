# Day 13  
  
## Exercise 01  

[Employee Application](https://github.com/compsciacademy/fulltime-program-2021-Q2/tree/main/Week03/Day12#exercise-03) continued...  
  
Our client is happy with the current state of progress. Now that they have had a chance to see the demo, they realized there were some features they wanted, that they forgot to mention, and are hoping to be able to have them added before they begin their initial alpha testing.  
  
The admin user would like to be able to use a text-based quering system, such that he would be able to perform the following type queries:  
  
```
find employee where email_address equals drew@drew.com
find employees where salary is greater than 25
find employees where vacation_days are less than 10
find employees where email_address is like *@company.com
```

Once that feature is enabled, they would like to test it out. However, before beginning alpha testing, they would also like to have the login feature enabled so employees can check their own vacation days, salaries, etc. as well as update their own email addresses.  
  
**Example Starter Repl**: [EmployeeQuery](https://replit.com/@DrewOgryzek/EmployeeQuery)  
  
## Bonus  

Up until now, we've used the `.each` method on arrays to iterate over a list of things. When we want to return a new list, or a subset of that list, or an otherwise changed version, we have created an empty array, pushed the new elements into that array and then returned that array.

E.g.

```ruby
def add_3(number_list)
    return_array = []
    number_list.each do |number|
        return_array << number + 3
    end
    return_array
end

add_3([1, 2, 3, 4, 5])
=> [4, 5, 6, 7, 8]

# we could use `.map` to return an array with
# the transformed data
# e.g.
def add_3(number_list)
    number_list.map do |number|
        number + 3
    end
end
```
