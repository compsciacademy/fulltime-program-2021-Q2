# Exercise 02 a.) Bonus I
# Write methods on the Order and OrderItem classes
# that will return the last saved item of each.  

class Order
    def self.last
        Order.new
    end 

    def order_number
        1
    end
end

class OrderItem
    def self.last
        OrderItem.new
    end

    def order
        Order.new
    end
end

# Test Cases

begin
    order = Order.last
    order_item = OrderItem.last
    if order_item.order.order_number == order.order_number && order_item.order.order_number && order.order_number
        puts "order_item.order.order_number: #{order_item.order.order_number == nil}"
        puts "order.order_number: #{order.order_number == nil}"
        
        puts "Yay! We did it!!!"
    else
        puts "Keep going!!"
    end
rescue StandardError => e
    puts "Not yet! Got an error: #{e.message}"
    puts "A few more steps. First start by resolving the error."
end

# Here are some operations you might want to perform with your objects. Use this as a start to write some test cases and then make them pass. The tests should ensure that your code behaves as described.  


# instantiate old order and order item objects
old_order = Order.last
old_order_item = OrderItem.last

# create a new order with an order item
order = Order.new
order_item = OrderItem.new(order)

# Save the order, which should also save the order's items
# and update the return values for Order.last and OrderItem.last
order.save

if old_order.order_number == order.order_number
    puts "Old Order should not ahve the same order number"
end

if old_order_item.order_number == order_item.order_number
    puts "Old Order Item should not have the same order number"
end

order = Order.last
order_item = OrderItem.last
if order_item.order.order_number == order.order_number && order_item.order.order_number && order.order_number
    puts "order_item.order.order_number: #{order_item.order.order_number == nil}"
    puts "order.order_number: #{order.order_number == nil}"
    
    puts "Yay! We did it!!!"
else
    puts "Keep going!!"
end


