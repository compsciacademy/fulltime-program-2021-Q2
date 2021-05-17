# Inventory system for Materials, Orders, Inventory, Warehousing/storage
#  --------------------------------------------------------------------
# We need to be able to add, modify, potentially clone materials
# and orders, that is CRUD operations of course... but also
# the idea of cloning. We can explore this as our app takes shape.
# 

class App
    def run
        loop do
            load_ui
        end
    end
end

#App.new.run

# Is there a difference between a material and an order item?
{
    "name": "iron-bar",
    "sku": "1005E111-iron",
    "properties": {"key": "value"},
    "cost": "",
    "supplier": "",
}

# Question: What is a Material? Indeed, wouldn't it be nice if we hade some use-cases
# for how our system should work?
#
#
#


my_array = [] 
my_hash = {}
my_array[0] = "hello"

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
