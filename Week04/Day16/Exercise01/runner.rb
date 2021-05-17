require './order'
require './order_item'

order = Order.new
item = OrderItem.new(order, "DooHickey", 19.95)

puts "Order Number: #{order.order_number}"
puts "Order Items: "
order.items.each_with_index do |item, index|
    puts "\t - (#{index}): #{item.name} @ #{item.price}"
end

puts item.order.order_number
