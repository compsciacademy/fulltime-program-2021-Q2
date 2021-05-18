# Write methods on the Order and OrderItem 
# classes that will return the last saved 
# item of each.  

order = Order.last
order_item = OrderItem.last

puts "This should be the last order: #{order.id}"
puts "This should be the last order item: #{order_item}"