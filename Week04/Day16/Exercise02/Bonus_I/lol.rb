# Exercise 02 a.) Bonus I
# Write methods on the Order and OrderItem classes
# that will return the last saved item of each.  

begin
    order = Order.last
    order_item = OrderItem.last
    if order_item.order.order_number == order.order_number
        puts "Yay! We did it!!!"
    else
        puts "Keep going!!"
    end
rescue StandardError => e
    puts "Not yet! Got an error: #{e.message}"
    puts "A few more steps. First start by resolving the error."
end
