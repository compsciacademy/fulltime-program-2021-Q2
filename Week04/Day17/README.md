# Day 17  
  
We left off with a homework assignment that was intended to challenge us to think through how we might save Orders and Order Items, without the complexity of the rest of the system.  
  
```ruby
# Exercise 02 a.) Bonus I
# Write methods on the Order and OrderItem classes
# that will return the last saved item of each.  

order = Order.last
order_item = OrderItem.last
```   
   
**HOMEWORK**: Check out the [`bonus.rb`](https://github.com/compsciacademy/fulltime-program-2021-Q2/blob/main/Week04/Day16/Exercise02/Bonus_I/bonus.rb#L43) for details.  
  
Good luck & Have fun!  
  
---
  
Let's open up a working file and satisfy the requirements for the homework. That is, "Write methods on the Order and OrderItem classes that will return the last saved item of each."  

--- 
  
## Exercise 01  

There is a bug in our system! We want to be able to instantiate Order objects without incrementing order numbers! Currently, due to the way we have developed our system, if I pull up existing order data and instantiate it into an Order object, it will increment the order numer! That means, everytime I want to look at old data, I'll be corrupting our system further.  
  
What can we do?  
  
Our `Order` class' `initialize` method seems to have some logic that we don't triggered if the Order isn't a new order:  
  
```ruby
# ...

    def initialize(sales_person)
        current_number = get_current_order_number
        @sales_person, @order_number, @items = sales_person, current_number, []
        update_order_number(current_number)
    end

# ...

    def get_current_order_number
        # will raise an exeption if the file `.order_number`
        # does not exist
        File.open('.order_number', 'r') do |file|
            file.map do |line| 
                current_order_number = line.to_i
            end.first
        end
    end

    def update_order_number(current_number)
        File.open('.order_number', 'w') do |file|
            file.write(current_number + 1)
        end
    end

# ...
```

What do we need to do differently so that we can actually work with out system?  
  