# Day 16  
  
Last time, we talked about extending our Project Management Application into a more fully-featured system. That included adding some concepts like Materials and Orders. There may be more to it that just those things, but let's see if we can [revisit the exercise](https://github.com/compsciacademy/fulltime-program-2021-Q2/tree/main/Week03/Day15#day-15), and walk through what may be required to make it happen.  
  


## (Revisited) c.) Back to the Project Management Application...

In addition to the above, projects have materials that are required for work to be done. Materials are ordered, and orders have delivery dates, prices, etc. really, all the things you'd expect an order to have.

Think through what type of functionality will need to be added to your application to support Project Material Order status, costs, delays, etc.

We will also want to (eventually) perform queries such as, "How much money was wasted on waiting for project material orders to be delivered?" (this is not in actual query syntax)  
  
---

## Exercise 01  
  
Let's take the above requirements that are intended for our Project Management System, and see if we can whip up a Material/Order/Inventory type system that will help us wrap our heads around what precisely we are building and adding to our system.  
  
With this company, since it has several projects on the go at any given time, and is continuously making orders, tracking delivery of materials, and which materials are available at project sites versus which materials need to be ordered (or moved from inventory), it also makes sense that they will have some way to store materials that they regularly use and need to have available at any given time.  
  
We will need to include methods for working with warehousing or storage locations, as well as some sort of mechanisms to determine what materials are available in inventory, where in inventory, whether we will need to order more or move materials to projects, etc.  
  
Thing through a system that only deals with the following: Materials, Orders, Inventory. What properties about each are important? How will our system behave?  
  
We already have the tools in our belt to develop a system that interacts with users through a command line interface, as well as is able to store data. Let's put this all together, and create an application for managing our inventory.  
  
---

In order to work on our assignment, let's think through the problem a little...  
  
Is there a difference between a material and an order item? What might they look like?  
```ruby
{
    "name": "iron-bar",
    "sku": "1005E111-iron",
    "properties": {"key": "value"},
    "cost": "",
    "supplier": ""
}
```

**Question**: What is a Material? Indeed, wouldn't it be nice if we hade some use-casesm for how our system should work?  
  
So glad you asked! Let's look at some use cases with example data. This should help us determine what our system needs to support in order for it to function properly.  
  
## Use Cases  
  
I should be able to search Materials based on the following:  
  
  * Supplier - should return a list of all materials from a given supplier
  * SKU - should return a list of all materials available from all suppliers (or in inventory) with a given SKU
  * Name - should return a list of all materials available from all suppliers (or in inventory) with a given Name
  * Description - should return a list of all materials available from all suppliers (or in inventory) with a similar Description

Some example material searches:  
  
```
find suppliers
find materials where cost is greater than 100 and cost is less than 1000
find locations where manager.email is drmanage@work.com

find suppliers where email is not sales@weldingsupplies.com
find materials where supplier.email is supplierOne@lolsupplies.com
find materials where sku is 555skuLoL
find materials where name is SteelBeam
find materials where description is like "available in yellow"
```

Other examples:  
```
find materials where name is StealBeam and location is '555 Mill Street' and cost is less than 5000
find materials where supplier.email is sales@weldingsupplies.com and sku is D15NA00111
find materials where order.date is before 05/05/2021 and order.date is after 01/05/2021 and project.location is '325 Davie Avenue'

find materials from suppliers where name is IronPellets and cost is less than 35 and cost is more than 10
```

**Working with Objects**:  
  
Whether we decide to use existing (built-in) data structures like Arrays and Hashes, or to create our own using Classes,
is up to us as the developer. If we would like to be able to do something with the data that a data structure holds, but
that functionality isn't provided with it, we might have a reasonable use-case for developing our own data structure and
that's a great time to opt for a Class.  
  
```ruby  
# Items have a name and price, and can be used
# to do things inside orders. That is, an OrderItem
# must belong to an Order.
class OrderItem
    attr_reader :name, :price, :order
    def initialize(order, name, price)
        @order, @name, @price = order, name, price
        @order.add_item(self)
    end
end

class Order
    attr_reader :order_number
    attr_accessor :items
    def initialize
        current_number = get_current_order_number
        @order_number, @items = current_number, []
        update_order_number(current_number)
    end

    def add_item(item)
        @items << item
    end

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
end

order = Order.new
item = OrderItem.new(order, "DooHickey", 19.95)

puts "Order Number: #{order.order_number}"
puts "Order Items: "
order.items.each_with_index do |item, index|
    puts "\t - (#{index}): #{item.name} @ #{item.price}"
end

puts item.order.order_number
```

In the above example, we have created an `OrderItem` that belongs to `Order` via the `Item`
constructor where an `Order` object is passed in. This allows us to add items to orders and
easily find the item's order or item's order's order number, etc.  
  
With this newfound view of the world of objects, how will will we develop our system?  
  
## Exercise 02
  
**a.) Start by Finishing Orders and Order Items**  
  
Extend the above classes to also support CRUD operations, which implies we will need to have functions that will create (save), update (find, change, and save), and of course delete (remove) records from whatever sort of data store we are using. In this case, we have saved some data to a file, that's a reasonable way to proceed with the other cases.  
  
**b.) But wait, there's more to be done...**  
   
We are also still missing materials, projects, locations, suppliers... and the list seems to never end.    
